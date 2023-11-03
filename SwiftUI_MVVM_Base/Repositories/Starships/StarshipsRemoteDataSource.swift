//
//  StarshipsRemoteDataSource.swift
//  SwiftUI_MVVM_Base
//
//  Created by Alex Morral on 3/10/22.
//

import Foundation

protocol StarshipsRemoteDataSourceProtocol {
    func fetchRemoteStarships() async throws -> [APIStarship]
    func fetchRemoteStarship(starshipId: String) async throws -> APIStarship
}

struct StarshipsRemoteDataSource: StarshipsRemoteDataSourceProtocol {
    private var apiClient: APIClientProtocol

    init(apiClient: APIClientProtocol = APIClient()) {
        self.apiClient = apiClient
    }

    func fetchRemoteStarships() async throws -> [APIStarship] {
        let decoder = JSONDecoder()

        let apiRequest = StarshipsEndpoint.starships

        let paginatedStarships: APIPaginatedResult<APIStarship> = try await apiClient.performRequest(
            apiRequest: apiRequest,
            decoder: decoder
        )
        return paginatedStarships.results
    }

    func fetchRemoteStarship(starshipId: String) async throws -> APIStarship {
        let decoder = JSONDecoder()

        let apiRequest = StarshipsEndpoint.starship(starshipId)

        return try await apiClient.performRequest(
            apiRequest: apiRequest,
            decoder: decoder
        )
    }
}
