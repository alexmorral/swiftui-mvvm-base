//
//  StarshipDetailView.swift
//  SwiftUI_MVVM_Base
//
//  Created by Alex Morral on 3/10/22.
//

import SwiftUI

struct StarshipDetailView: View {
    @ObservedObject var viewModel: StarshipDetailViewModel

    var body: some View {
        VStack {
            switch viewModel.viewState {
            case .idle:
                idleView
            case .loading:
                ProgressView()
            case .error:
                VStack {
                    Text("Error loading starship")
                    Button(action: viewModel.loadData) {
                        Text("Try again")
                    }
                }
            }
        }
        .navigationTitle("Starship")
    }

    @ViewBuilder
    var idleView: some View {
        Form {
            Section("Details") {
                detailCell(leadingText: "Name", trailingText: viewModel.starship.name)
                detailCell(leadingText: "Model", trailingText: viewModel.starship.model)
                detailCell(leadingText: "Manufacturer", trailingText: viewModel.starship.manufacturer)
                detailCell(leadingText: "Starship class", trailingText: viewModel.starship.starshipClass)
            }
            Section("Specs") {
                detailCell(leadingText: "Length", trailingText: viewModel.starship.length)
                detailCell(leadingText: "Max atmosphering speed", trailingText: viewModel.starship.maxAtmospheringSpeed)
            }
            Section("Cargo") {
                detailCell(leadingText: "Crew", trailingText: viewModel.starship.crew)
                detailCell(leadingText: "Passengers", trailingText: viewModel.starship.passengers)
                detailCell(leadingText: "Cargo capacity", trailingText: viewModel.starship.cargoCapacity)
                detailCell(leadingText: "Consumables", trailingText: viewModel.starship.consumables)
            }
            Section("About") {
                detailCell(leadingText: "Cost in credits", trailingText: viewModel.starship.costInCredits)
                detailCell(leadingText: "Hyperdrive Rating", trailingText: viewModel.starship.hyperdriveRating)
                detailCell(leadingText: "MGLT", trailingText: viewModel.starship.mglt)
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: viewModel.toggleStarshipFavorite) {
                    Image(systemName: viewModel.isStarshipFavorite ? "heart.fill" : "heart")
                }
            }
        }
    }

    func detailCell(leadingText: String, trailingText: String) -> some View {
        HStack {
            Text(leadingText)
            Spacer()
            Text(trailingText)
                .font(.footnote)
        }
    }
}

#Preview {
    StarshipDetailBuilder()
        .buildView(
            routeIdentifier: "",
            router: MainRouter(),
            starshipId: ""
        )
}
