//
//  ReminderCellView.swift
//  ReminderApp
//
//  Created by Никита Яровой on 21.03.2025.
//

import SwiftUI

enum ReminderCellIvent {
    case onInfo
    case onCheckChanged(Reminder)
    case onSelect(Reminder)
}

struct ReminderCellView: View {
    let reminder: Reminder
    @State private var checked: Bool = false
    let onEvent: (ReminderCellIvent) -> Void
    
    private func formatdate(_ date: Date) -> String {
        if date.isToday {
            return "Today"
        } else if date.isTomorrow {
            return "Tomorrow"
        } else {
            return date.formatted(date: .numeric, time: .omitted)
        }
    }
    
    var body: some View {
        HStack {
            Image(systemName: checked ? "circle.inset.filled": "circle")
                .font(.title3)
                .opacity(0.4)
                .onTapGesture {
                    checked.toggle()
                    onEvent(.onCheckChanged(reminder))
                }
            
            VStack(alignment: .leading) {
                Text(reminder.title ?? "")
                
                if let notes = reminder.notes, !notes.isEmpty {
                    Text(notes)
                        .opacity(0.4)
                        .font(.caption)
                }
                
                HStack {
                    if let reminderDate = reminder.reminderDate {
                        Text(formatdate(reminderDate))
                    }
                    
                    if let reminderTime = reminder.reminderTime {
                        Text(reminderTime.formatted(date: .omitted, time: .shortened))
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.caption)
                .opacity(0.4)
            }
                
            Spacer()
            Image(systemName: "info.circle.fill")
                .onTapGesture {
                    onEvent(.onInfo)
                }
        }.contentShape(Rectangle())
            .onTapGesture {
                onEvent(.onSelect(reminder))
            }
    }
}

#Preview {
    ReminderCellView(reminder: PreviewData.reminder, onEvent: { _ in })
}
