//
//  ReminderStatsBuilder.swift
//  ReminderApp
//
//  Created by Никита Яровой on 25.03.2025.
//

import Foundation
import SwiftUI

enum ReminderStatType {
    case today
    case all
    case scheduled
    case completed
}

struct ReminderStatsValue {
    var todayCount: Int = 0
    var scheduledCount: Int = 0
    var completedCount: Int = 0
    var allCount: Int = 0
}

struct ReminderStatsBuilder {
    func build(mylistResults: FetchedResults<MyList>) -> ReminderStatsValue {
        let remindersArray = mylistResults.map { $0.remindersArray }.reduce([], +)
        
        let allCount = calculateAllCount(reminders: remindersArray)
        let completedCount = calculateCompletedCount(reminders: remindersArray)
        let todaysCount = calculateTodaysCount(reminders: remindersArray)
        let scheduledCount = calculateScheduledCount(reminders: remindersArray)
        
        return ReminderStatsValue(todayCount: todaysCount, scheduledCount: scheduledCount, completedCount: completedCount, allCount: allCount)
    }
    
    private func calculateAllCount(reminders: [Reminder]) -> Int {
        return reminders.reduce(0) { result, reminder in
            return !reminder.isCompleated ? result + 1 : result
        }
    }
    
    private func calculateCompletedCount(reminders: [Reminder]) -> Int {
        return reminders.reduce(0) { result, reminder in
            return reminder.isCompleated ? result + 1 : result
        }
    }
    
    private func calculateTodaysCount(reminders: [Reminder]) -> Int {
        return reminders.reduce(0) { result, reminder in
            let isToday = reminder.reminderDate?.isToday ?? false
            return isToday ? result + 1 : result
        }
    }
    
    private func calculateScheduledCount(reminders: [Reminder]) -> Int {
        return reminders.reduce(0) { result, reminder in
            return ((reminder.reminderDate != nil || reminder.reminderTime != nil) && !reminder.isCompleated) ? result + 1 : result
        }
    }
}
