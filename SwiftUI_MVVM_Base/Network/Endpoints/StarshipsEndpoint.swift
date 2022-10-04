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
    var baseURL: String {
        "https://swapi.dev/api"
    }

    var path: String {
        switch self {
        case .starships:
            return "/starships"
        case .starship(let starshipId):
            return "/starships/\(starshipId)"
        }
    }

    var httpMethod: String {
        switch self {
        case .starships, .starship:
            return "GET"
        }
    }

    var httpBody: Data? {
        nil
    }

    var isResponsePaginated: Bool {
        switch self {
        case .starships:
            return true
        default:
            return false
        }
    }

    func buildRequest() throws -> URLRequest {
        guard let url = URL(string: "\(baseURL)\(path)") else {
            throw APIError.badURL
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod
        urlRequest.httpBody = httpBody
        return urlRequest
    }
}
