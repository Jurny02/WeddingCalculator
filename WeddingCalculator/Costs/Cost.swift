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

    var paymentProgressString: String {
        "\(Int((paidAmount / fullAmount) * 100))%"
    }

    var paymentStatusText: String {
        if amountToPay == 0 {
            return "Fully Paid"
        } else if paidAmount == 0 {
            return "Not Paid"
        } else {
            return "Partially Paid"
        }
    }

    var paymentStatusColor: Color {
        guard fullAmount > 0 else { return .gray }

        let hue: Double
        if progress < 0.8 {
            hue = 0.0 + (0.16 * (progress / 0.8))
        } else {
            hue = 0.16 + (0.17 * ((progress - 0.8) / 0.2))
        }

        return Color(hue: hue, saturation: 0.9, brightness: 0.9)
    }

    private var progress: Double {
        paidAmount / fullAmount
    }

    init(name: String, fullAmount: Double, paidAmount: Double) {
        self.id = UUID()
        self.name = name
        self.fullAmount = fullAmount
        self.paidAmount = paidAmount
    }

    func update(with model: NewCostModel) {
        name = model.name
        paidAmount = model.paidAmount
        fullAmount = model.fullAmount
    }
}

#if DEBUG
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

extension Cost {
    static var fakeData: Cost {
        .init(name: "DJ", fullAmount: 6000, paidAmount: 1000)
    }
}
#endif
