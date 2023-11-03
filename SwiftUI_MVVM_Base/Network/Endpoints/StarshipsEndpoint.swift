//
//  StarshipsEndpoint.swift
//  SwiftUI_MVVM_Base
//
//  Created by Alex Morral on 3/10/22.
//

import Foundation

enum StarshipsEndpoint {
    case starships
    case starship(String)
}

extension StarshipsEndpoint: APIRequest {
    var path: String {
        switch self {
        case .starships:
            return "starships"
        case .starship(let starshipId):
            return "starships/\(starshipId)"
        }
    }

    var httpMethod: String {
        switch self {
        case .starships, .starship:
            return "GET"
        }
    }

    var isResponsePaginated: Bool {
        switch self {
        case .starships:
            return true
        default:
            return false
        }
    }
}
