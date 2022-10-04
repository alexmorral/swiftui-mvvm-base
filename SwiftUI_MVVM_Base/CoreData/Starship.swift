//
//  Starship.swift
//  SwiftUI_MVVM_Base
//
//  Created by Alex Morral on 3/10/22.
//

import Foundation
import CoreData

@objc(Starship)
class Starship: NSManagedObject, Codable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        // TODO: Rest of values
    }

    required convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw CoreDataError.missingContext
        }

        self.init(context: context)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.model = try container.decode(String.self, forKey: .model)
        self.manufacturer = try container.decode(String.self, forKey: .manufacturer)
        self.costInCredits = try container.decodeIfPresent(String.self, forKey: .costInCredits)
        self.length = try container.decodeIfPresent(String.self, forKey: .length)
        self.maxAtmospheringSpeed = try container.decodeIfPresent(String.self, forKey: .maxAtmospheringSpeed)
        self.crew = try container.decodeIfPresent(String.self, forKey: .crew)
        self.passengers = try container.decodeIfPresent(String.self, forKey: .passengers)
        self.cargoCapacity = try container.decodeIfPresent(String.self, forKey: .cargoCapacity)
        self.consumables = try container.decodeIfPresent(String.self, forKey: .consumables)
        self.hyperdriveRating = try container.decodeIfPresent(String.self, forKey: .hyperdriveRating)
        self.mglt = try container.decodeIfPresent(String.self, forKey: .mglt)
        self.starshipClass = try container.decodeIfPresent(String.self, forKey: .starshipClass)
        self.url = try container.decode(String.self, forKey: .url)
    }

    enum CodingKeys: String, CodingKey {
        case name, model, manufacturer
        case costInCredits = "cost_in_credits"
        case length
        case maxAtmospheringSpeed = "max_atmosphering_speed"
        case crew, passengers
        case cargoCapacity = "cargo_capacity"
        case consumables
        case hyperdriveRating = "hyperdrive_rating"
        case mglt = "MGLT"
        case starshipClass = "starship_class"
        case url
    }
}

extension Starship {
    var id: String {
        guard let url,
              let urlString = URL(string: url) else {
            return UUID().uuidString
        }
        return urlString.lastPathComponent
    }
}
