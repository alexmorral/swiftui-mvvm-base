//
//  StarshipViewModel.swift
//  SwiftUI_MVVM_Base
//
//  Created by Alex Morral on 3/10/22.
//

import Foundation

struct StarshipViewModel: Identifiable {
    private var starship: Starship

    init(starship: Starship) {
        self.starship = starship
    }

    var id: String { starship.id }
    var name: String { starship.name ?? "-" }
    var model: String { starship.model ?? "-" }
    var manufacturer: String { starship.manufacturer ?? "-" }
    var costInCredits: String { starship.costInCredits ?? "-" }
    var length: String { starship.length ?? "-" }
    var maxAtmospheringSpeed: String { starship.maxAtmospheringSpeed ?? "-" }
    var crew: String { starship.crew ?? "-" }
    var passengers: String { starship.passengers ?? "-" }
    var cargoCapacity: String { starship.cargoCapacity ?? "-" }
    var consumables: String { starship.consumables ?? "-" }
    var hyperdriveRating: String { starship.hyperdriveRating ?? "-" }
    var mglt: String { starship.mglt ?? "-" }
    var starshipClass: String { starship.starshipClass ?? "-" }
}
