//
//  StarshipDetailViewModel.swift
//  SwiftUI_MVVM_Base
//
//  Created by Alex Morral on 3/10/22.
//

import SwiftUI

final class StarshipDetailViewModel: ObservableObject {
    private var router: MainRouter
    private var starshipRepository: StarshipsRepositoryProtocol
    let starshipId: String

    @Published var starship: StarshipViewModel!
    @Published var viewState = ViewState.loading
    @Published var isStarshipFavorite: Bool = false

    enum ViewState {
        case idle
        case loading
        case error
    }

    init(
        router: MainRouter,
        starshipId: String,
        starshipRepository: StarshipsRepositoryProtocol
    ) {
        self.router = router
        self.starshipId = starshipId
        self.starshipRepository = starshipRepository
        loadData()
    }

    func loadData() {
        viewState = .loading
        Task { @MainActor in
            do {
                let starshipObject = try await starshipRepository.retrieveStarship(starshipId: starshipId)
                self.starship = StarshipViewModel(starship: starshipObject)
                isStarshipFavorite = starshipRepository.isStarshipFavorite(id: starship.id)
                viewState = .idle
            } catch {
                error.printCatchError()
                viewState = .error
            }
        }
    }

    func toggleStarshipFavorite() {
        do {
            if isStarshipFavorite {
                try starshipRepository.unmarkStarshipFavorite(id: starship.id)
                isStarshipFavorite = false
            } else {
                try starshipRepository.markStarshipFavorite(id: starship.id)
                isStarshipFavorite = true
            }
        } catch {
            error.printCatchError()
        }
    }
}
