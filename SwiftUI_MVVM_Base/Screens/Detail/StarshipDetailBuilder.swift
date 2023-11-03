//
//  StarshipDetailBuilder.swift
//  SwiftUI_MVVM_Base
//
//  Created by Alex Morral on 3/11/23.
//

import SwiftUI

class StarshipDetailBuilder: ObservableObject {
    private var storedViewModels = NSMapTable<NSString, StarshipDetailViewModel>(
        keyOptions: NSPointerFunctions.Options.strongMemory,
        valueOptions: NSPointerFunctions.Options.weakMemory
    )

    func buildView(
        routeIdentifier: NSString,
        router: MainRouter,
        starshipId: String
    ) -> some View {
        let viewModel = storedViewModels.object(forKey: routeIdentifier) ??
        initViewModel(routeIdentifier: routeIdentifier, router: router, starshipId: starshipId)

        return StarshipDetailView(viewModel: viewModel)
    }

    private func initViewModel(
        routeIdentifier: NSString,
        router: MainRouter,
        starshipId: String
    ) -> StarshipDetailViewModel {
        // Inject dependencies
        let viewModel = StarshipDetailViewModel(
            router: router,
            starshipId: starshipId,
            starshipRepository: StarshipsRepository()
        )
        storedViewModels.setObject(viewModel, forKey: routeIdentifier)

        return viewModel
    }
}
