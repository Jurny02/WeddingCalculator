//
//  CalculatorPersistence.swift
//  WeddingCalculator
//
//  Created by Bartosz Jurczyk on 29/08/2025.
//

import Foundation
import OSLog

protocol CalculatorPersistence {
    func get() throws -> CalculatorStateDTO
    func save(_ state: CalculatorStateDTO) throws
}

class DefaultCalculatorPersistence: CalculatorPersistence {
    enum Constants {
        static let savedStateKey: String = "calculatorState"
    }

    enum CPError: Error {
        case loadingError
        case savingError
    }

    private let logger = getLogger(category: "DefaultCalculatorPersistence")
    private let userDefaults = UserDefaults.standard

    func get() throws(CPError) -> CalculatorStateDTO {
        guard
            let data = userDefaults.data(forKey: Constants.savedStateKey),
            let calculatorState = try? JSONDecoder().decode(CalculatorStateDTO.self, from: data)
        else {
            logger.error("Failed to load calculator state")
            throw .loadingError
        }
        return calculatorState
    }

    func save(_ state: CalculatorStateDTO) throws(CPError) {
        guard let encode = try? JSONEncoder().encode(state) else {
            logger.error("Failed to save calculator state")
            throw .savingError
        }
        userDefaults.set(encode, forKey: Constants.savedStateKey)
    }
}
