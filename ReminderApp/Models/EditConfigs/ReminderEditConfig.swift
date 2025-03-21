//
//  ReminderEditConfig.swift
//  ReminderApp
//
//  Created by Никита Яровой on 21.03.2025.
//

import Foundation

struct ReminderEditConfig {
    var title: String = ""
    var notes: String?
    var isCompleated: Bool = false
    var hasDate: Bool = false
    var hasTime: Bool = false
    var reminderDate: Date?
    var reminderTime: Date?
    
    init() {}
    
    init(reminder: Reminder) {
        title = reminder.title ?? ""
        notes = reminder.notes
        isCompleated = reminder.isCompleated
        reminderDate = reminder.reminderDate
        reminderTime = reminder.reminderTime
        hasDate = reminder.reminderDate != nil
        hasTime = reminder.reminderTime != nil
    }
}
