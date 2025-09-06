//
//  CalculatorManager.swift
//  WeddingCalculator
//
//  Created by Bartosz Jurczyk on 02/09/2025.
//

import SwiftUI
import OSLog

@Observable
class CalculatorManager {
    enum CMError: Error {
        case saveFailed
        case loadFailed
    }

    let persistence: CalculatorPersistence
    var calculatorState = CalculatorState()

    private let logger = Logger(subsystem: "com.bartoszjurczyk.WeddingCalculator",
                                category: "CalculatorManager")
    init(persistence: CalculatorPersistence = DefaultCalculatorPersistence()) {
        self.persistence = persistence
    }

    func save() throws(CMError) {
        do {
            try persistence.save(CalculatorStateDTO(from: calculatorState))
        } catch {
            throw .saveFailed
        }
    }

    func getData() throws(CMError) {
        do {
            let result = try persistence.get()
            update(with: result)
        } catch {
            throw .loadFailed
        }
    }

    private func update(with state: CalculatorStateDTO) {
        calculatorState.update(with: state)
    }
}
