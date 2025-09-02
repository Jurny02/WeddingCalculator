//
//  CalculatorPersistenceMock.swift
//  WeddingCalculator
//
//  Created by Bartosz Jurczyk on 02/09/2025.
//

import Foundation

class MockCalculatorPersistence: CalculatorPersistence {
    var getResult: Result<CalculatorStateDTO, Error>?
    var saveResult: Result<Void, Error>?

    enum ErrorState: Error {
        case failed
    }

    private(set) var lastSavedState: CalculatorStateDTO?

    func get() throws -> CalculatorStateDTO {
        switch getResult {
        case .success(let state):
            return state
        case .failure(let error):
            throw error
        case .none:
            throw ErrorState.failed
        }
    }

    func save(_ state: CalculatorStateDTO) throws {
        lastSavedState = state
        switch saveResult {
        case .success:
            return
        case .failure(let error):
            throw error
        case .none:
            return
        }
    }
}
