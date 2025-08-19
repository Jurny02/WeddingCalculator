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
            Tab("Home", systemImage: "house") {
                Color.red
            }
            Tab("Settings", systemImage: "gear") {
                Color.blue
            }
        }
    }
}

#Preview {
    MainTabView()
}
