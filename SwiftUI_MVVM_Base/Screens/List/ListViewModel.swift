//
//  ListViewModel.swift
//  SwiftUI_MVVM_Base
//
//  Created by Alex Morral on 3/10/22.
//

import SwiftUI

final class ListViewModel: ObservableObject {
    @Published var route: [Route]
    private var starshipRepository: StarshipsRepositoryProtocol = StarshipsRepository()

    @Published var starships: [StarshipViewModel] = []

    init() {
        self.route = []
        loadData()
    }

    func loadData() {
        Task { @MainActor in
            do {
                let starshipObjects = try await starshipRepository.retrieveStarships()
                self.starships = starshipObjects.map { StarshipViewModel(starship: $0) }
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
    }

    func starshipTapped(starshipId: String) {
        route.append(.detail(starshipId: starshipId))
    }
}
