//
//  NotificationManager.swift
//  ReminderApp
//
//  Created by Никита Яровой on 26.03.2025.
//

import Foundation
import UserNotifications

struct UserData {
    let title: String?
    let body: String?
    let date: Date?
    let time: Date?
}

class NotificationManager {
    static func scheduleNotification(userdData: UserData) {
      let content = UNMutableNotificationContent()
        content.title = userdData.title ?? ""
        content.body = userdData.body ?? ""
        
        var dateComponent = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: userdData.date ?? Date())
        
        if let reminderTime = userdData.time {
            let reminderTimeDateComponents = reminderTime.dateComponents
            dateComponent.hour = reminderTimeDateComponents.hour
            dateComponent.minute = reminderTimeDateComponents.minute
        }
        
        let triger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: false)
        let request = UNNotificationRequest(identifier: "Reminder Notification", content: content, trigger: triger)
        UNUserNotificationCenter.current().add(request)
    }
}
