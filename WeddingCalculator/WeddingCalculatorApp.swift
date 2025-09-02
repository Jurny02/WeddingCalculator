//
//  WeddingCalculatorApp.swift
//  WeddingCalculator
//
//  Created by Bartosz Jurczyk on 23/07/2025.
//

import SwiftUI
import SwiftData

@main
struct WeddingCalculatorApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Cost.self, GuestModel.self])
    }
}
