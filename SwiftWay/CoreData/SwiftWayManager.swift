//
//  SwiftWayManager.swift
//  SwiftWay
//
//  Created by Татьяна Касперович on 6.06.24.
//

import CoreData
import SwiftUI

class SwiftWayManager {
    // Singleton...
    static let instance = SwiftWayManager()
    
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    init() {
        container = NSPersistentContainer(name: "SwiftWayContainer")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Error loading Core Data. \(error)")
            }
        }
        context = container.viewContext
    }
    
    func save() {
        do {
            try context.save()
            print("Saved successfully!")
        } catch let error {
            print("Error saving Core Data. \(error.localizedDescription)")
        }
    }
}
