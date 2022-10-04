//
//  APICommons.swift
//  SwiftUI_MVVM_Base
//
//  Created by Alex Morral on 3/10/22.
//

import Foundation
import CoreData

struct APIParser {
    static let defaultDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()

    static func decoder(with context: NSManagedObjectContext) -> JSONDecoder {
        let decoder = defaultDecoder
        decoder.userInfo[CodingUserInfoKey.managedObjectContext] = context
        return decoder
    }
}
