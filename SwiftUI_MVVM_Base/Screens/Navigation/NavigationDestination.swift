//
//  NavigationDestination.swift
//  SwiftUI_MVVM_Base
//
//  Created by Alex Morral on 3/11/23.
//

import Foundation

public struct NavigationDestination: Hashable {
    enum Destination: Hashable {
        case detail(starshipId: String)
    }

    let destination: Destination
    let identifier: NSString = UUID().uuidString as NSString

    init(destination: Destination) {
        self.destination = destination
    }

    public static func == (lhs: NavigationDestination, rhs: NavigationDestination) -> Bool {
        lhs.identifier == rhs.identifier
    }
}

public enum ModalDestination: Identifiable {
    case modal

    public var id: Int { hashValue }
}
