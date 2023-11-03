//
//  StarshipListViewModel.swift
//  SwiftUI_MVVM_Base
//
//  Created by Alex Morral on 3/10/22.
//

import SwiftUI

final class StarshipListViewModel: ObservableObject {
    private var router: MainRouter
    private var starshipRepository: StarshipsRepositoryProtocol

    @Published var starships: [StarshipViewModel] = []
    @Published var viewState = ViewState.loading

    init(
        router: MainRouter,
        starshipRepository: StarshipsRepositoryProtocol
    ) {
        self.router = router
        self.starshipRepository = starshipRepository
        loadData()
    }

    enum ViewState {
        case idle
        case loading
        case error
    }

    func loadData() {
        viewState = .loading
        Task { @MainActor in
            do {
                let starshipObjects = try await starshipRepository.retrieveStarships()
                self.starships = starshipObjects.map { StarshipViewModel(starship: $0) }
                viewState = .idle
            } catch {
                error.printCatchError()
                viewState = .error
            }
        }
    }

    func starshipTapped(starshipId: String) {
        router.navigate(to: .init(destination: .detail(starshipId: starshipId)))
    }
}
