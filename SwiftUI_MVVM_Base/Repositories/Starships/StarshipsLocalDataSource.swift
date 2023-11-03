//
//  StarshipsLocalDataSource.swift
//  SwiftUI_MVVM_Base
//
//  Created by Alex Morral on 3/10/22.
//

import Foundation
import CoreData

protocol StarshipsLocalDataSourceProtocol {
    var coreDataManager: CoreDataManagerProtocol { get }

    func isStarshipFavorite(id: String) -> Bool
    func markStarshipFavorite(id: String) throws
    func unmarkStarshipFavorite(id: String) throws
}

struct StarshipsLocalDataSource: StarshipsLocalDataSourceProtocol {
    let coreDataManager: CoreDataManagerProtocol

    init(coreDataManager: CoreDataManagerProtocol = CoreDataManager.shared) {
        self.coreDataManager = coreDataManager
    }

    func isStarshipFavorite(id: String) -> Bool {
        let context = coreDataManager.mainContext

        let fetchRequest = StarshipFavorite.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "starshipId = %@", id)

        let favorites = (try? context.fetch(fetchRequest)) ?? []

        return !favorites.isEmpty
    }

    func markStarshipFavorite(id: String) throws {
        let context = coreDataManager.backgroundContext

        let favorite = StarshipFavorite(context: context)
        favorite.starshipId = id
        favorite.timestamp = Date.now

        try context.save()
    }

    func unmarkStarshipFavorite(id: String) throws {
        let context = coreDataManager.backgroundContext

        let fetchRequest = StarshipFavorite.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "starshipId = %@", id)

        for item in try context.fetch(fetchRequest) {
            context.delete(item)
        }

        try context.save()
    }
}
