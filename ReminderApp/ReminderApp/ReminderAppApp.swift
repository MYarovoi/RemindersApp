//
//  ReminderAppApp.swift
//  ReminderApp
//
//  Created by Никита Яровой on 19.03.2025.
//

import SwiftUI

@main
struct ReminderAppApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, CoreDataProvider.shared.persistentContainer.viewContext)
        }
    }
}
