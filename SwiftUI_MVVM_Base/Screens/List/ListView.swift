//
//  ListView.swift
//  SwiftUI_MVVM_Base
//
//  Created by Alex Morral on 3/10/22.
//

import SwiftUI

struct ListView: View {
    @ObservedObject var viewModel: ListViewModel

    var body: some View {
        NavigationStack(path: $viewModel.route) {
            List(viewModel.starships) { starship in
                HStack {
                    VStack(alignment: .leading) {
                        Text(starship.name)
                        Text(starship.model)
                            .font(.caption)
                    }
                    Spacer()
                    Button(action: { viewModel.starshipTapped(starshipId: starship.id) }){
                        Image(systemName: "chevron.right")
                            .font(.body)
                            .foregroundColor(Color(UIColor.tertiaryLabel))
                    }
                }
            }
            .navigationDestination(for: Route.self) { route in
                route.view(with: $viewModel.route)
            }
            .navigationTitle("Starships")
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(viewModel: ListViewModel())
    }
}
