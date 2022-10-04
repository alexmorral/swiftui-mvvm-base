//
//  DetailViewModel.swift
//  SwiftUI_MVVM_Base
//
//  Created by Alex Morral on 3/10/22.
//

import SwiftUI

final class DetailViewModel: ObservableObject {
    @Binding private var route: [Route]
    private var starshipRepository = StarshipsRepository()
    let starshipId: String

    @Published var starship: StarshipViewModel!
    @Published var viewState = ViewState.loading

    enum ViewState {
        case idle
        case loading
        case error
    }

    init(
        route: Binding<[Route]>,
        starshipId: String
    ) {
        self._route = route
        self.starshipId = starshipId
        loadData()
    }

    func loadData() {
        viewState = .loading
        Task { @MainActor in
            do {
                let starshipObject = try await starshipRepository.retrieveStarship(starshipId: starshipId)
                self.starship = StarshipViewModel(starship: starshipObject)
                viewState = .idle
            } catch {
                print("Error: \(error.localizedDescription)")
                viewState = .error
            }
        }
    }
}
