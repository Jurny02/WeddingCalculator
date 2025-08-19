//
//  NavigationManager.swift
//  WeddingCalculator
//
//  Created by Bartosz Jurczyk on 16/08/2025.
//

import SwiftUI

// MARK: - Generic Navigation Manager
@MainActor
class NavigationManager<T>: ObservableObject {
    @Published var navigationPath: [T] = []
    
    // MARK: - Navigation Methods
    func navigate(to destination: T) {
        navigationPath.append(destination)
    }
    
    func navigateBack() {
        if !navigationPath.isEmpty {
            navigationPath.removeLast()
        }
    }
    
    func navigateToRoot() {
        navigationPath.removeAll()
    }

    func replaceCurrent(with destination: T) {
        if !navigationPath.isEmpty {
            navigationPath.removeLast()
        }
        navigationPath.append(destination)
    }
}
