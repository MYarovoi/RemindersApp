//
//  PreviewData.swift
//  ReminderApp
//
//  Created by Mykyta Yarovoi on 20.03.2025.
//

import Foundation
import CoreData

class PreviewData {
    static var myList: MyList {
        let viewContext = CoreDataProvider.shared.persistentContainer.viewContext
        let request = MyList.fetchRequest()
        return (try? viewContext.fetch(request).first) ?? MyList()
    }
}
