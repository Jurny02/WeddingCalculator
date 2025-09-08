//
//  NewCostModel.swift
//  WeddingCalculator
//
//  Created by Bartosz Jurczyk on 07/09/2025.
//

import SwiftUI
import SwiftData

@Observable
class NewCostModel {
    enum NCMError: Error {
        case savingFailed
        case validationFailed
    }

    var name: String
    var fullAmount: Double
    var paidAmount: Double

    var amountToPay: Double { max(fullAmount - paidAmount, 0) }

    var isInvalid: Bool {
        trimmedName.isEmpty ||
        fullAmount <= 0 ||
        paidAmount < 0 ||
        paidAmount > fullAmount
    }

    init(name: String = "", fullAmount: Double = 0, paidAmount: Double = 0) {
        self.name = name
        self.fullAmount = fullAmount
        self.paidAmount = paidAmount
    }

    convenience init(form cost: Cost) {
        self.init(
            name: cost.name,
            fullAmount: cost.fullAmount,
            paidAmount: cost.paidAmount
        )
    }

    func addCostToContext(context: ModelContext) throws(NCMError) {
        let cost = try createCost()
        context.insert(cost)
    }

    func createCost() throws(NCMError) -> Cost {
        guard isInvalid == false else {
            throw .validationFailed
        }

        return Cost(
            name: trimmedName,
            fullAmount: fullAmount,
            paidAmount: paidAmount
        )
    }

    private var trimmedName: String {
        name.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
