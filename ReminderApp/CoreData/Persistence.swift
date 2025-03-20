//
//  Persistence.swift
//  ReminderApp
//
//  Created by Никита Яровой on 19.03.2025.
//

import CoreData

struct CoreDataProvider {
    static let shared = CoreDataProvider()
    let persistentContainer: NSPersistentContainer

    private init() {
        //register transformer
        ValueTransformer.setValueTransformer(UIColorTransformer(), forName: NSValueTransformerName("UIColorTransformer"))
        
        persistentContainer = NSPersistentContainer(name: "ReminderApp")
        persistentContainer.loadPersistentStores { description, error in
            if let error {
                print("DEBUG: Failed to load CoreData persistent stores: \(error.localizedDescription)")
            }
        }
    }
}
