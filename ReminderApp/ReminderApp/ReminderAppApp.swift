//
//  ReminderAppApp.swift
//  ReminderApp
//
//  Created by Никита Яровой on 19.03.2025.
//

import SwiftUI
import UserNotifications

@main
struct ReminderAppApp: App {
    
    init() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted {
                
            } else {
                
            }
        }
    }
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, CoreDataProvider.shared.persistentContainer.viewContext)
        }
    }
}
