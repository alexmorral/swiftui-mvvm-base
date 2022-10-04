//
//  Route.swift
//  SwiftUI_MVVM_Base
//
//  Created by Alex Morral on 3/10/22.
//

import SwiftUI

enum Route {
    case detail(starshipId: String)

    @ViewBuilder
    func view(with route: Binding<[Route]>) -> some View {
        switch self {
        case .detail(let starshipId):
            let viewModel = DetailViewModel(
                route: route,
                starshipId: starshipId
            )
            DetailView(viewModel: viewModel)
        }
    }
}

extension Route: Equatable, Hashable {
    static func == (lhs: Route, rhs: Route) -> Bool {
        lhs.hashValue == rhs.hashValue
    }

    func hash(into hasher: inout Hasher) {}
}
