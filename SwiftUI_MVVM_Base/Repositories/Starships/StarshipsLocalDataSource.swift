//
//  StarshipsLocalDataSource.swift
//  SwiftUI_MVVM_Base
//
//  Created by Alex Morral on 3/10/22.
//

import Foundation
import CoreData

protocol StarshipsLocalDataSourceProtocol {
    func fetchStarships() throws -> [Starship]
    func fetchStarship(starshipId: String) throws -> Starship
}

struct StarshipsLocalDataSource: StarshipsLocalDataSourceProtocol {
    let coreDataManager: CoreDataManagerProtocol

    init(coreDataManager: CoreDataManagerProtocol = CoreDataManager.shared) {
        self.coreDataManager = coreDataManager
    }

    func fetchStarships() throws -> [Starship] {
        let fetchRequest: NSFetchRequest<Starship> = Starship.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]

        return try coreDataManager.viewContext.fetch(fetchRequest)
    }

    func fetchStarship(starshipId: String) throws -> Starship {
        // This shouldn't be like this, but the API does not provide `id` to its objects.
        guard let starship = try fetchStarships().first(where: { $0.id == starshipId }) else {
            throw CoreDataError.objectNotFound
        }
        return starship
    }
}
