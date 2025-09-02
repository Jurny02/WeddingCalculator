//
//  CostsView.swift
//  WeddingCalculator
//
//  Created by Bartosz Jurczyk on 14/08/2025.
//

import SwiftUI
import SwiftData

@Model
class Cost: Identifiable {

    var id: UUID
    var name: String
    var fullAmount: Double
    var paidAmount: Double

    var amountToPay: Double {
        fullAmount - paidAmount
    }

    init(name: String, fullAmount: Double, paidAmount: Double) {
        self.id = UUID()
        self.name = name
        self.fullAmount = fullAmount
        self.paidAmount = paidAmount
    }

    static var fakeData: Cost {
        .init(name: "DJ", fullAmount: 6000, paidAmount: 1000)
    }
}

extension [Cost] {
    static var fakeData: [Cost] {
        [
            .init(name: "DJ", fullAmount: 6000, paidAmount: 1000),
            .init(name: "Sala", fullAmount: 6000, paidAmount: 3000),
            .init(name: "Content", fullAmount: 2500, paidAmount: 500),
            .init(name: "Kwiaty", fullAmount: 4000, paidAmount: 0)
        ]
    }
}
