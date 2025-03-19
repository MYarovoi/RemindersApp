//
//  Persistence.swift
//  ReminderApp
//
//  Created by Никита Яровой on 19.03.2025.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    let persistentContainer: NSPersistentContainer

    private init() {
        persistentContainer = NSPersistentContainer(name: "ReminderApp")
        persistentContainer.loadPersistentStores { description, error in
            if let error {
                print("DEBUG: Failed to load CoreData persistent stores: \(error.localizedDescription)")
            }
        }
    }
}
