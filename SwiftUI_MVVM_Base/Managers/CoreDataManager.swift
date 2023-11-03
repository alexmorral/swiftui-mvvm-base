//
//  CoreDataManager.swift
//  SwiftUI_MVVM_Base
//
//  Created by Alex Morral on 3/10/22.
//

import Foundation
import CoreData

protocol CoreDataManagerProtocol {
    var mainContext: NSManagedObjectContext { get }
    var backgroundContext: NSManagedObjectContext { get }

    func save(context: NSManagedObjectContext) throws
    func delete(object: NSManagedObject, context: NSManagedObjectContext)
}

final class CoreDataManager: NSObject, CoreDataManagerProtocol {

    override init() {}

    static let shared = CoreDataManager()

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "SwiftUI_MVVM_Base")
        container.loadPersistentStores { (_, error) in
            container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            if let error = error as NSError? {
                preconditionFailure("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    var mainContext: NSManagedObjectContext {
        let context = persistentContainer.viewContext
        context.automaticallyMergesChangesFromParent = true
        return context
    }

    var backgroundContext: NSManagedObjectContext {
        let context = persistentContainer.newBackgroundContext()
        context.automaticallyMergesChangesFromParent = true
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return context
    }

    // MARK: - Core Data Saving support

    func save(context: NSManagedObjectContext) {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func delete(object: NSManagedObject, context: NSManagedObjectContext) {
        context.performAndWait {
            context.delete(object)
        }
    }
}
