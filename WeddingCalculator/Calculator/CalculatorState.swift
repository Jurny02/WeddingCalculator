//
//  CalculatorState.swift
//  WeddingCalculator
//
//  Created by Bartosz Jurczyk on 19/08/2025.
//

import Foundation
import SwiftData
import OSLog

@Observable
class CalculatorState {
    var weddingDate: Date
    var currentSavings: Double
    var currentSavingsEUR: Double
    var groomMonthly: Double
    var brideMonthly: Double

    var monthsUntilWedding: Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.month], from: Date(), to: weddingDate)
        return max(components.month ?? 0, 0)
    }

    var totalAtWedding: Double {
        let savingsEuro = currentSavingsEUR * 4.3
        let futureSaved = Double(monthsUntilWedding) * (groomMonthly + brideMonthly)
        return currentSavings + savingsEuro + futureSaved
    }

    init(
        date: Date = Date(),
        currentSavings: Double = 0,
        currentSavingsEUR: Double = 0,
        groomMonthly: Double = 0,
        brideMonthly: Double = 0
    ) {
        self.weddingDate = date
        self.currentSavings = currentSavings
        self.currentSavingsEUR = currentSavingsEUR
        self.groomMonthly = groomMonthly
        self.brideMonthly = brideMonthly
    }

    private func update(with state: CalculatorStateDTO) {
        weddingDate = state.date
        currentSavings = state.currentSavings
        currentSavingsEUR = state.currentSavingsEUR
        groomMonthly = state.groomMonthly
        brideMonthly = state.brideMonthly
    }
}
