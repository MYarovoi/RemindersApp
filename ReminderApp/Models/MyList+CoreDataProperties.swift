//
//  MyList+CoreDataProperties.swift
//  ReminderApp
//
//  Created by Никита Яровой on 19.03.2025.
//
//

import Foundation
import CoreData
import UIKit


extension MyList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MyList> {
        return NSFetchRequest<MyList>(entityName: "MyList")
    }

    @NSManaged public var name: String
    @NSManaged public var color: UIColor
    @NSManaged public var reminders: NSSet?
}

extension MyList : Identifiable {

}

extension MyList {
    @objc(addRemindersObject:)
    @NSManaged public func addToReminders(_ value: Reminder)
    
    @objc(removeRemindersObject:)
    @NSManaged public func removeFromReminders(_ value: Reminder)
    
    @objc(addReminders:)
    @NSManaged public func addToReminders(_ value: NSSet)
    
    @objc(removeReminders:)
    @NSManaged public func removeFromReminders(_ value: NSSet)
}
