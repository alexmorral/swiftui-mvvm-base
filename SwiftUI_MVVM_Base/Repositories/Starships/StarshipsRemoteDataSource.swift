//
//  StarshipsRemoteDataSource.swift
//  SwiftUI_MVVM_Base
//
//  Created by Alex Morral on 3/10/22.
//

import Foundation

protocol StarshipsRemoteDataSourceProtocol {
    func fetchRemoteStarships() async throws
    func fetchRemoteStarship(starshipId: String) async throws
}

struct StarshipsRemoteDataSource: StarshipsRemoteDataSourceProtocol {
    private var apiClient: APIClientProtocol
    private var coreDataManager: CoreDataManagerProtocol

    init(
        apiClient: APIClientProtocol = APIClient(),
        coreDataManager: CoreDataManagerProtocol = CoreDataManager.shared
    ) {
        self.apiClient = apiClient
        self.coreDataManager = coreDataManager
    }

    func fetchRemoteStarships() async throws {
        let context = coreDataManager.backgroundContext()
        let decoder = APIParser.decoder(with: context)

        let apiRequest = StarshipsEndpoint.starships

        let _: APIPaginatedResult<Starship> = try await apiClient.performRequest(
            apiRequest: apiRequest,
            decoder: decoder
        )
        coreDataManager.save(context: context)
    }

    func fetchRemoteStarship(starshipId: String) async throws {
        let context = coreDataManager.backgroundContext()
        let decoder = APIParser.decoder(with: context)

        let apiRequest = StarshipsEndpoint.starship(starshipId)

        let _: Starship = try await apiClient.performRequest(
            apiRequest: apiRequest,
            decoder: decoder
        )
        coreDataManager.save(context: context)
    }
}
