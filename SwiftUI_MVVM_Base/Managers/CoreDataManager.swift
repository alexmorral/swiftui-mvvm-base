//
//  CoreDataManager.swift
//  SwiftUI_MVVM_Base
//
//  Created by Alex Morral on 3/10/22.
//

import Foundation
import CoreData

protocol CoreDataManagerProtocol {
    var persistentContainer: NSPersistentContainer { get }
    var viewContext: NSManagedObjectContext { get }

    func backgroundContext(with parentContext: NSManagedObjectContext?) -> NSManagedObjectContext
    func save(context: NSManagedObjectContext)
    func delete(object: NSManagedObject, in context: NSManagedObjectContext)
}

extension CoreDataManagerProtocol {
    func backgroundContext(with parentContext: NSManagedObjectContext? = nil) -> NSManagedObjectContext {
        backgroundContext(with: parentContext)
    }
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

    var viewContext: NSManagedObjectContext {
        let context = persistentContainer.viewContext
        context.automaticallyMergesChangesFromParent = true
        return context
    }


    func backgroundContext(with parentContext: NSManagedObjectContext? = nil) -> NSManagedObjectContext {
        let context = persistentContainer.newBackgroundContext()
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        if let parentContext {
            context.parent = parentContext
        }
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

    // MARK: - Core Data Deleting support
    func delete(object: NSManagedObject, in context: NSManagedObjectContext) {
        context.delete(object)
    }
}
