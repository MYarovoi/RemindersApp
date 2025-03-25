//
//  ContentView.swift
//  ReminderApp
//
//  Created by Никита Яровой on 19.03.2025.
//

import SwiftUI
import CoreData

struct HomeView: View {
    @FetchRequest(sortDescriptors: [])
    private var myListResults: FetchedResults<MyList>
    
    @FetchRequest(sortDescriptors: [])
    private var searchResults: FetchedResults<Reminder>
    
    @FetchRequest(fetchRequest: ReminderServis.remindersByStatType(.all))
    private var allResults: FetchedResults<Reminder>
    
    @FetchRequest(fetchRequest: ReminderServis.remindersByStatType(.completed))
    private var completedResults: FetchedResults<Reminder>
    
    @FetchRequest(fetchRequest: ReminderServis.remindersByStatType(.scheduled))
    private var scheduledResults: FetchedResults<Reminder>
    
    @FetchRequest(fetchRequest: ReminderServis.remindersByStatType(.today))
    private var todayResults: FetchedResults<Reminder>
    
    @State private var isPresented: Bool = false
    @State private var search: String = ""
    @State private var searching: Bool = false
    
    private var reminderStatsBuiled = ReminderStatsBuilder()
    @State var reminderSatsValues = ReminderStatsValue()
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    HStack {
                        NavigationLink {
                            ReminderListView(reminders: todayResults)
                        } label: {
                            ReminderStatsView(icon: "calendar", title: "Today", count: reminderSatsValues.todayCount, iconColor: .blue)
                        }

                        NavigationLink {
                            ReminderListView(reminders: allResults)
                        } label: {
                            ReminderStatsView(icon: "tray.circle.fill", title: "All", count: reminderSatsValues.allCount, iconColor: .red)
                        }
                    }
                    
                    HStack {
                        NavigationLink {
                            ReminderListView(reminders: scheduledResults)
                        } label: {
                            ReminderStatsView(icon: "calendar.circle.fill", title: "Scheduled", count: reminderSatsValues.scheduledCount, iconColor: .primary)
                        }

                        NavigationLink {
                            ReminderListView(reminders: completedResults)
                        } label: {
                            ReminderStatsView(icon: "checkmark.circle.fill", title: "Completed", count: reminderSatsValues.completedCount, iconColor: .secondary)
                        }
                    }
                    
                    Text("My Lists")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    
                    MyListsView(myLists: myListResults)
                    
                    Button {
                        isPresented = true
                    } label: {
                        Text("Add List")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .font(.headline)
                    }.padding()
                }
            }.onChange(of: search, perform: { searchTerm in
                searching = !searchTerm.isEmpty ? true : false
                searchResults.nsPredicate = ReminderServis.getReminderBySearchTerm(search).predicate
            })
            .overlay(alignment: .center, content: {
                ReminderListView(reminders: searchResults)
                    .opacity(searching ? 1 : 0)
            })
            .sheet(isPresented: $isPresented) {
                NavigationStack {
                    AddNewListView { name, color in
                        do {
                            try ReminderServis.saveMyList(name, color)
                        } catch {
                            print("DEBUG: \(error.localizedDescription)")
                        }
                    }
                }
            }.onAppear {
                reminderSatsValues = reminderStatsBuiled.build(mylistResults: myListResults)
            }
            .padding()
        }.searchable(text: $search)
    }
}

    
    #Preview {
        HomeView()
            .environment(\.managedObjectContext, CoreDataProvider.shared.persistentContainer.viewContext)
    }

