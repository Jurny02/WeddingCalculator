//
//  TabView.swift
//  WeddingCalculator
//
//  Created by Bartosz Jurczyk on 14/08/2025.
//

import SwiftUI

struct MainTabView : View {
    var body: some View {
        TabView {
            GuestListView( )
                .tabItem {
                    Label("Guests", systemImage: "person.2.fill")
                }
            WeddingSavingsCalculatorView()
                .tabItem {
                    Label("Calculator", systemImage: "equal")
                }

            CostListView()
                .tabItem {
                    Label("Costs", systemImage: "creditcard")
                }
        }
        .snackbar()
    }
}

#Preview {
    ContentView()
        .environment(SnackbarManager())
}
