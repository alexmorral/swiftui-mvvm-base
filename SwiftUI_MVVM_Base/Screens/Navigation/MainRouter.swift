//
//  MainRouter.swift
//  SwiftUI_MVVM_Base
//
//  Created by Alex Morral on 3/11/23.
//

import SwiftUI

protocol Router {
    associatedtype Destination: Hashable
    associatedtype Modal: Identifiable

    var navPath: NavigationPath { get }
    var presentedSheet: Modal? { get }

    func navigate(to destination: Destination)
    func navigateBack()
    func navigateToRoot()
    func present(modal: Modal)
    func dismiss()
}

public final class MainRouter: Router, ObservableObject {
    @Published public var navPath = NavigationPath()
    @Published public var presentedSheet: ModalDestination?
    @Published var presentedContext: Binding<ModalDestination?>

    public init(presentedContext: Binding<ModalDestination?> = .constant(nil)) {
        self.presentedContext = presentedContext
    }

    public func navigate(to destination: NavigationDestination) {
        navPath.append(destination)
    }

    public func navigateBack() {
        navPath.removeLast()
    }

    public func navigateToRoot() {
        navPath.removeLast(navPath.count)
    }

    public func present(modal: ModalDestination) {
        presentedSheet = modal
    }

    public func dismiss() {
        presentedContext.wrappedValue = nil
    }
}
