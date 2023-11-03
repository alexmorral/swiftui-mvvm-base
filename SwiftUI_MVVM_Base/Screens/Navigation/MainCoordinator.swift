//
//  MainCoordinator.swift
//  SwiftUI_MVVM_Base
//
//  Created by Alex Morral on 3/11/23.
//

import SwiftUI

struct MainCoordinator: View {
    @ObservedObject var router = MainRouter()

    @StateObject var starshipListBuilder = StarshipListBuilder()
    @StateObject var starshipDetailBuilder = StarshipDetailBuilder()

    init(router: MainRouter = MainRouter()) {
        self.router = router
    }

    var body: some View {
        NavigationStack(path: $router.navPath) {
            starshipListBuilder
                .buildView(
                    routeIdentifier: "root",
                    router: router
                )
                .navigationDestination(for: NavigationDestination.self) { destination in
                    switch destination.destination {
                    case .detail(let starshipId):
                        starshipDetailBuilder
                            .buildView(
                                routeIdentifier: destination.identifier,
                                router: router,
                                starshipId: starshipId
                            )
                    }
                }
        }
        .sheet(item: $router.presentedSheet) { modal in
            switch modal {
            case .modal:
                EmptyView()
            }
        }
    }
}

#Preview {
    MainCoordinator()
}
