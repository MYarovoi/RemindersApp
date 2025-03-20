//
//  ReminderServic.swift
//  ReminderApp
//
//  Created by Mykyta Yarovoi on 20.03.2025.
//

import Foundation
import CoreData
import UIKit

class ReminderServis {
    static var viewContext: NSManagedObjectContext {
        CoreDataProvider.shared.persistentContainer.viewContext
    }
    
    static func save() throws {
        try viewContext.save()
    }
    
    static func saveMyList(_ name: String, _ color: UIColor) throws {
        let myList = MyList(context: viewContext)
        myList.name = name
        myList.color = color
        try save()
    }
}
