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
            Text(reminder.title ?? "")
        }
    }
}
