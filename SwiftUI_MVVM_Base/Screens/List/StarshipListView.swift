//
//  StarshipListView.swift
//  SwiftUI_MVVM_Base
//
//  Created by Alex Morral on 3/10/22.
//

import SwiftUI

struct StarshipListView: View {
    @ObservedObject var viewModel: StarshipListViewModel

    var body: some View {
        VStack {
            switch viewModel.viewState {
            case .idle:
                idleView
            case .loading:
                ProgressView()
            case .error:
                VStack {
                    Text("Error loading starships")
                    Button(action: viewModel.loadData) {
                        Text("Try again")
                    }
                }
            }
        }
        .navigationTitle("Starships")
    }

    @ViewBuilder
    var idleView: some View {
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
    }
}

#Preview {
    StarshipListBuilder()
        .buildView(
            routeIdentifier: "",
            router: MainRouter()
        )
}
