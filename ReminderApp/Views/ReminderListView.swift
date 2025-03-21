//
//  ReminderListView.swift
//  ReminderApp
//
//  Created by Mykyta Yarovoi on 20.03.2025.
//

import SwiftUI

struct ReminderListView: View {
    let reminders: FetchedResults<Reminder>
    
    var body: some View {
        List(reminders) { reminder in
            ReminderCellView(reminder: reminder) { event in
                switch event {
                case .onCheckChanged(let reminder):
                    print("")
                case .onSelect(let reminder):
                    print("")
                case .onInfo:
                    print("")
                }
            }
        }
    }
}
