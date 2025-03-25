//
//  ReminderListView.swift
//  ReminderApp
//
//  Created by Mykyta Yarovoi on 20.03.2025.
//

import SwiftUI

struct ReminderListView: View {
    let reminders: FetchedResults<Reminder>
    @State private var selectedReminder: Reminder?
    @State private var showReminderDetail: Bool = false
    
    private func reminderCheckedChanged(reminder: Reminder, isCompleated: Bool) {
        var editConfig = ReminderEditConfig(reminder: reminder)
        editConfig.isCompleated = isCompleated
        
        do {
            let _ = try ReminderServis.updateReminder(reminder: reminder, editConfig: editConfig)
        } catch {
            print("DEBUG: Error updating reminder: \(error.localizedDescription)")
        }
    }
    
    private func isRemiderSelected(_ reminder: Reminder) -> Bool {
        selectedReminder?.objectID == reminder.objectID
    }
    
    private func deleteReminder(_ indexSet: IndexSet) {
        indexSet.forEach { index in
            let reminder = reminders[index]
            do {
                try ReminderServis.deleteReminder(reminder: reminder)
            } catch {
                print("DEBUG: Error deleting reminder: \(error.localizedDescription)")
            }
        }
    }
    
    var body: some View {
        VStack {
            List {
                ForEach(reminders) { reminder in
                    ReminderCellView(reminder: reminder, isSelected: isRemiderSelected(reminder)) { event in
                        switch event {
                        case .onCheckChanged(let reminder, let isCompleated):
                            reminderCheckedChanged(reminder: reminder, isCompleated: isCompleated)
                        case .onSelect(let reminder):
                            selectedReminder = reminder
                        case .onInfo:
                            showReminderDetail = true
                        }
                    }
                }.onDelete(perform: deleteReminder)
            }
        }.sheet(isPresented: $showReminderDetail) {
            ReminderDetailView(reminder: Binding($selectedReminder)!)
        }
    }
}
