//
//  ContentView.swift
//  WeddingCalculator
//
//  Created by Bartosz Jurczyk on 23/07/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var snackbarManager = SnackbarManager()
    var body: some View {
        MainTabView()
            .environment(snackbarManager)
    }
}

#Preview {
    ContentView()
        .environment(SnackbarManager())
}
