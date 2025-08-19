//
//  TabView.swift
//  WeddingCalculator
//
//  Created by Bartosz Jurczyk on 14/08/2025.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            GuestListView()
                .tabItem {
                    Label("goscie", systemImage: "list.dash")
                }
            WeddingSavingsCalculatorView()
                .tabItem {
                    Label("calculator", systemImage: "list.dash")
                }
            
            CostListView()
                .tabItem {
                    Label("Order", systemImage: "square.and.pencil")
                }
        }
    }
}

#Preview {
    ContentView(startdestination: .main)
}
