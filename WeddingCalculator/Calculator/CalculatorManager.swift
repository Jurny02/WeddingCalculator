//
//  CalculatorManager.swift
//  WeddingCalculator
//
//  Created by Bartosz Jurczyk on 02/09/2025.
//

import SwiftUI

@Observable
class CalculatorManager {
    let persistence: CalculatorPersistence

    var calculatorState = CalculatorState()

    init(
        persistence: CalculatorPersistence = DefaultCalculatorPersistence()
    ) {
        self.persistence = persistence
    }

    func save() throws {
        try persistence.save(.init(from: <#T##CalculatorState#>))
    }

    func getData() {
        guard let result = try? persistence.get() else { return }
        update(with: result)
    }

    private func update(with state: CalculatorStateDTO) {
       
    }
}
