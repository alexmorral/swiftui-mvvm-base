//
//  StarshipListBuilder.swift
//  SwiftUI_MVVM_Base
//
//  Created by Alex Morral on 3/11/23.
//

import SwiftUI

class StarshipListBuilder: ObservableObject {
    private var storedViewModels = NSMapTable<NSString, StarshipListViewModel>(
        keyOptions: NSPointerFunctions.Options.strongMemory,
        valueOptions: NSPointerFunctions.Options.weakMemory
    )

    func buildView(
        routeIdentifier: NSString,
        router: MainRouter
    ) -> some View {
        let viewModel = storedViewModels.object(forKey: routeIdentifier) ??
        initViewModel(routeIdentifier: routeIdentifier, router: router)

        return StarshipListView(viewModel: viewModel)
    }

    private func initViewModel(
        routeIdentifier: NSString,
        router: MainRouter
    ) -> StarshipListViewModel {
        // Inject dependencies
        let viewModel = StarshipListViewModel(
            router: router,
            starshipRepository: StarshipsRepository()
        )
        storedViewModels.setObject(viewModel, forKey: routeIdentifier)

        return viewModel
    }
}
