//
//  StarshipsRepository.swift
//  SwiftUI_MVVM_Base
//
//  Created by Alex Morral on 3/10/22.
//

import Foundation

protocol StarshipsRepositoryProtocol {
    func retrieveStarships() async throws -> [APIStarship]
    func retrieveStarship(starshipId: String) async throws -> APIStarship
    func isStarshipFavorite(id: String) -> Bool
    func markStarshipFavorite(id: String) throws
    func unmarkStarshipFavorite(id: String) throws
}

struct StarshipsRepository: StarshipsRepositoryProtocol {
    private var localDataSource: StarshipsLocalDataSourceProtocol
    private var remoteDataSource: StarshipsRemoteDataSourceProtocol

    init(
        localDataSource: StarshipsLocalDataSourceProtocol = StarshipsLocalDataSource(),
        remoteDataSource: StarshipsRemoteDataSourceProtocol = StarshipsRemoteDataSource()
    ) {
        self.localDataSource = localDataSource
        self.remoteDataSource = remoteDataSource
    }

    func retrieveStarships() async throws -> [APIStarship] {
        try await remoteDataSource.fetchRemoteStarships()
    }

    func retrieveStarship(starshipId: String) async throws -> APIStarship {
        try await remoteDataSource.fetchRemoteStarship(starshipId: starshipId)
    }

    func isStarshipFavorite(id: String) -> Bool {
        localDataSource.isStarshipFavorite(id: id)
    }

    func markStarshipFavorite(id: String) throws {
        try localDataSource.markStarshipFavorite(id: id)
    }

    func unmarkStarshipFavorite(id: String) throws {
        try localDataSource.unmarkStarshipFavorite(id: id)
    }
}
