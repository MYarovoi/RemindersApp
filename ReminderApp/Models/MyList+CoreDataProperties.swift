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
}

extension MyList : Identifiable {

}
