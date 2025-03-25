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
    
    static func updateReminder(reminder: Reminder, editConfig: ReminderEditConfig) throws -> Bool {
        let reminderToUpdate = reminder
        reminderToUpdate.isCompleated = editConfig.isCompleated
        reminder.title = editConfig.title
        reminder.notes = editConfig.notes
        reminderToUpdate.reminderDate = editConfig.hasDate ? editConfig.reminderDate : nil
        reminderToUpdate.reminderTime = editConfig.hasTime ? editConfig.reminderTime : nil
        try save()
        return true
    }
    
    static func deleteReminder(reminder: Reminder) throws {
        viewContext.delete(reminder)
        try save()
    }
    
    static func saveReminderToMyList(myList: MyList, reminderTitle: String) throws {
        let reminder = Reminder(context: viewContext)
        reminder.title = reminderTitle
        myList.addToReminders(reminder)
        try save()
    }
    
    static func getRemindersByList(myList: MyList) -> NSFetchRequest<Reminder> {
        let request = Reminder.fetchRequest()
        request.sortDescriptors = []
        request.predicate = NSPredicate(format: "list = %@ AND isCompleated = false", myList)
        return request
    }
    
    static func getReminderBySearchTerm(_ search: String) -> NSFetchRequest<Reminder> {
        let request = Reminder.fetchRequest()
        request.sortDescriptors = []
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", search)
        return request
    }
    
    static func remindersByStatType(_ statType: ReminderStatType) -> NSFetchRequest<Reminder> {
        let request = Reminder.fetchRequest()
        request.sortDescriptors = []
        switch statType {
        case .scheduled:
            request.predicate = NSPredicate(format: "reminderDate != nil OR reminderTime != nil AND isCompleated = false")
        case .completed:
            request.predicate = NSPredicate(format: "isCompleated = true")
        case .all:
            request.predicate = NSPredicate(format: "isCompleated = false")
        case .today:
            let today = Date()
            let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: today)!
            request.predicate = NSPredicate(format: "(reminderDate BETWEEN {%@, %@}) OR (reminderTime BETWEEN {%@, %@})", today as NSDate, tomorrow as NSDate)
        }
        
        return request
    }
}
