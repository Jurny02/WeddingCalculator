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
    enum Constants {
        static let savedStateKey: String = "calculatorState"
    }
    
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
        currentSavings + currentSavingsEUR * 4.3 + (Double(monthsUntilWedding) * (groomMonthly + brideMonthly))
    }
    
    init(date: Date = Date(), currentSavings: Double = 0, currentSavingsEUR: Double = 0, groomMonthly: Double = 0, brideMonthly: Double = 0) {
        self.weddingDate = date
        self.currentSavings = currentSavings
        self.currentSavingsEUR = currentSavingsEUR
        self.groomMonthly = groomMonthly
        self.brideMonthly = brideMonthly
    }
    
    func save() {
        if let encode = try? JSONEncoder().encode(CalculatorStateDTO(from: self)) {
            UserDefaults.standard.set(encode, forKey: Constants.savedStateKey)
        } else {
            let logger = Logger()
            logger.info("Failed to save calculator state")
        }
    }
    
    func getData() {
        guard
            let data = UserDefaults.standard.data(forKey: Constants.savedStateKey),
            let loadedData = try? JSONDecoder().decode(CalculatorStateDTO.self, from: data)
        else { return }
        
        update(with: loadedData)
    }
    
    private func update(with state: CalculatorStateDTO) {
        weddingDate = state.date
        currentSavings = state.currentSavings
        currentSavingsEUR = state.currentSavingsEUR
        groomMonthly = state.groomMonthly
        brideMonthly = state.brideMonthly
    }
    
    private struct CalculatorStateDTO: Codable {
        var date: Date
        var currentSavings: Double
        var currentSavingsEUR: Double
        var groomMonthly: Double
        var brideMonthly: Double
        
        init(from calculatorSate: CalculatorState) {
            self.date = calculatorSate.weddingDate
            self.currentSavings = calculatorSate.currentSavings
            self.currentSavingsEUR = calculatorSate.currentSavingsEUR
            self.groomMonthly = calculatorSate.groomMonthly
            self.brideMonthly = calculatorSate.brideMonthly
        }
    }
}
