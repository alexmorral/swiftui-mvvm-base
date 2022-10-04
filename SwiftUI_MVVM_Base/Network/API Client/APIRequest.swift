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
    var httpHeaders: [String: Any] { get }
    var httpBody: Data? { get }
    var isResponsePaginated: Bool { get }

    func buildRequest() throws -> URLRequest
}

extension APIRequest {
    var httpHeaders: [String: Any] {
        [
            "Content-Type": "application/json"
        ]
    }
}
