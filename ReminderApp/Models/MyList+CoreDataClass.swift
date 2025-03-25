//
//  MyList+CoreDataClass.swift
//  ReminderApp
//
//  Created by Никита Яровой on 19.03.2025.
//
//

import Foundation
import CoreData

@objc(MyList)
public class MyList: NSManagedObject {
    var remindersArray: [Reminder] {
        reminders?.allObjects.compactMap { $0 as? Reminder } ?? []
    }
}
