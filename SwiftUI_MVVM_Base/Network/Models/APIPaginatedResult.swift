//
//  APIPaginatedResult.swift
//  SwiftUI_MVVM_Base
//
//  Created by Alex Morral on 3/10/22.
//

import Foundation

struct APIPaginatedResult<T: Codable>: Codable {
    var count: Int
    var next: String?
    var previous: String?
    var results: [T]

    enum CodingKeys: String, CodingKey {
        case count
        case next
        case previous
        case results
    }
}
