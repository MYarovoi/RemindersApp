//
//  MyListDetailView.swift
//  ReminderApp
//
//  Created by Mykyta Yarovoi on 20.03.2025.
//

import SwiftUI

struct MyListDetailView: View {
    let myList: MyList
    @State private var openAddReminder: Bool = false
    @State private var title: String = ""
    
    @FetchRequest(sortDescriptors: [])
    private var reminderResults: FetchedResults<Reminder>
    
    private var isFormValid: Bool {
        !title.isEmpty
    }
    
    init(myList: MyList) {
        self.myList = myList
        _reminderResults = FetchRequest(fetchRequest: ReminderServis.getRemindersByList(myList: myList))
    }
    
    var body: some View {
        VStack {
            ReminderListView(reminders: reminderResults)
            
            HStack {
                Image(systemName: "plus.circle.fill")
                Button("New Reminder") {
                    openAddReminder = true
                }
            }
            .foregroundStyle(.blue)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }.alert("New Reminder", isPresented: $openAddReminder) {
            TextField("", text: $title)
            Button("Cancel", role: .cancel) { }
            Button("Done") {
                do {
                    try ReminderServis.saveReminderToMyList(myList: myList, reminderTitle: title)
                } catch {
                    print("DEBUG: \(error.localizedDescription)")
                }
            }.disabled(!isFormValid)
        }
    }
}

#Preview {
    MyListDetailView(myList: PreviewData.myList)
}
