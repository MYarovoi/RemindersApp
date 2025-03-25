//
//  ReminderDetailView.swift
//  ReminderApp
//
//  Created by Никита Яровой on 21.03.2025.
//

import SwiftUI

struct ReminderDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var reminder: Reminder
    @State var editConfig = ReminderEditConfig()
    private var isValid: Bool {
        !editConfig.title.isEmpty
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Section {
                        TextField("Title", text: $editConfig.title)
                        TextField("Notes", text: $editConfig.notes ?? "")
                    }
                    
                    Section {
                        Toggle(isOn: $editConfig.hasDate) {
                            Image(systemName: "calendar")
                                .foregroundStyle(.red)
                        }
                        
                        if editConfig.hasDate {
                            DatePicker("Select date", selection: $editConfig.reminderDate ?? Date(), displayedComponents: .date)
                        }
                        
                        Toggle(isOn: $editConfig.hasTime) {
                            Image(systemName: "clock")
                                .foregroundStyle(.blue)
                        }
                        
                        if editConfig.hasTime {
                            DatePicker("Select date", selection: $editConfig.reminderTime ?? Date(), displayedComponents: .hourAndMinute)
                        }
                        
                        Section {
                            NavigationLink {
                                SelectListView(selectedList: $reminder.list)
                            } label: {
                                HStack {
                                    Text("List")
                                    Spacer()
                                    Text(reminder.list!.name)
                                }
                            }

                        }.onChange(of: editConfig.hasDate) { hasDate in
                            if hasDate {
                                editConfig.reminderDate = Date()
                            }
                        }
                        .onChange(of: editConfig.hasTime) { hasTime in
                            if hasTime {
                                editConfig.reminderTime = Date()
                            }
                        }
                    }
                }.listStyle(.insetGrouped)
            }.onAppear {
                editConfig = ReminderEditConfig(reminder: reminder)
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Details")
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                            do {
                                let _ = try ReminderServis.updateReminder(reminder: reminder, editConfig: editConfig)
                            } catch {
                                print("DEBUG: Fail to update reminder \(error.localizedDescription)")
                            }
                        dismiss()
                    }.disabled(!isValid)
                }
            }
        }
    }
}

#Preview {
    ReminderDetailView(reminder: .constant(PreviewData.reminder))
}
