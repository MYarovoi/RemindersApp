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
    
    @State private var isPresented: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                MyListsView(myLists: myListResults)
                                
                Button {
                    isPresented = true
                } label: {
                    Text("Add List")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .font(.headline)
                }.padding()
            }.sheet(isPresented: $isPresented) {
                NavigationStack {
                    AddNewListView { name, color in
                        do {
                            try ReminderServis.saveMyList(name, color)
                        } catch {
                            print("DEBUG: \(error.localizedDescription)")
                        }
                    }
                }
            }
        }
        .padding()
    }
}

    
    #Preview {
        HomeView()
            .environment(\.managedObjectContext, CoreDataProvider.shared.persistentContainer.viewContext)
    }

