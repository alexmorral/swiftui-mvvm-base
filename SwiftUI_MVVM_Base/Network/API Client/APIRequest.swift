//
//  APIRequest.swift
//  SwiftUI_MVVM_Base
//
//  Created by Alex Morral on 3/10/22.
//

import Foundation

protocol APIRequest {
    var baseURL: String { get }
    var path: String { get }
    var httpMethod: String { get }
    var httpHeaders: [String: String] { get }
    var queryItems: [URLQueryItem] { get }
    var httpBody: Data? { get }
    var isResponsePaginated: Bool { get }

    func buildRequest() throws -> URLRequest
}

extension APIRequest {
    var baseURL: String {
        "https://swapi.dev/api/"
    }

    var httpHeaders: [String: String] {
        [
            "Content-Type": "application/json"
        ]
    }

    func buildRequest() throws -> URLRequest {
        guard
            let url = URL(string: baseURL),
            var urlRequest = appendURLParameters(url)
        else {
            throw APIError.badURL
        }
        urlRequest.httpMethod = httpMethod
        urlRequest.httpBody = httpBody
        urlRequest.allHTTPHeaderFields = httpHeaders
        return urlRequest
    }

    var httpBody: Data? { return nil }
    var queryItems: [URLQueryItem] { [] }

    private func appendURLParameters(_ requestURL: URL) -> URLRequest? {
        guard let url = URL(string: path, relativeTo: requestURL),
              var components = URLComponents(
                url: url, resolvingAgainstBaseURL: true
              ) else {
            logger.error("Bad path name \(path)")
            return nil
        }
        components.queryItems = queryItems
        guard let finalURL = components.url else {
            logger.error("Failed URLComponent")
            return nil
        }
        return URLRequest(url: finalURL)
    }
}
