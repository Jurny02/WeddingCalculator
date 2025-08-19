//
//  ContentView.swift
//  WeddingCalculator
//
//  Created by Bartosz Jurczyk on 23/07/2025.
//

import SwiftUI

struct ContentView: View {
    private let startdestination: MainDestinations
    init(startdestination: MainDestinations = .login) {
        self.startdestination = startdestination
    }
    var body: some View {
        MainTabView()
    }
}

enum MainDestinations {
    case login
    case main
}

#Preview {
    ContentView()
}

private struct PathKey: EnvironmentKey {
    static let defaultValue: Binding<[MainDestinations]> = .constant([])
}

extension EnvironmentValues {
    var path: Binding<[MainDestinations]> {
        get { self[PathKey.self] }
        set { self[PathKey.self] = newValue }
    }
}
