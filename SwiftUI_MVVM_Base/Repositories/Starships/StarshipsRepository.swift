//
//  StarshipsRepository.swift
//  SwiftUI_MVVM_Base
//
//  Created by Alex Morral on 3/10/22.
//

import Foundation

protocol StarshipsRepositoryProtocol {
    func retrieveStarships() async throws -> [Starship]
    func retrieveStarship(starshipId: String) async throws -> Starship
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

    func retrieveStarships() async throws -> [Starship] {
        try await remoteDataSource.fetchRemoteStarships()
        return try localDataSource.fetchStarships()
    }

    func retrieveStarship(starshipId: String) async throws -> Starship {
        try await remoteDataSource.fetchRemoteStarship(starshipId: starshipId)
        return try localDataSource.fetchStarship(starshipId: starshipId)
    }
}
