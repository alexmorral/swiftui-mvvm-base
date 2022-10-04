//
//  APIClient.swift
//  SwiftUI_MVVM_Base
//
//  Created by Alex Morral on 3/10/22.
//

import Foundation

protocol APIClientProtocol {
    func performRequest<T: Codable>(
        apiRequest: APIRequest,
        decoder: JSONDecoder
    ) async throws -> T
}

struct APIClient: APIClientProtocol {
    var session = URLSession.shared

    func performRequest<T: Codable>(
        apiRequest: APIRequest,
        decoder: JSONDecoder
    ) async throws -> T {
        let urlRequest = try apiRequest.buildRequest()
        let (data, urlResponse) = try await session.data(for: urlRequest)
        guard let httpResponse = urlResponse as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
                  throw APIError.badRequest
        }
        return try decoder.decode(T.self, from: data)
    }
}
