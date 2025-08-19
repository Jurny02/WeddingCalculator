//
//  CostsView.swift
//  WeddingCalculator
//
//  Created by Bartosz Jurczyk on 14/08/2025.
//

import SwiftUI

struct Cost: Identifiable {
    
    let id: UUID = UUID()
    let name: String
    let fullAmount: Double
    let paidAmount: Double
    
    var amountToPay: Double {
        fullAmount - paidAmount
    }
    
    static var fakeData: Self {
        .init(name: "DJ", fullAmount: 6000, paidAmount: 1000)
    }
}

extension [Cost] {
    static var fakeData: [Cost] {
        [
            .init(name: "DJ", fullAmount: 6000, paidAmount: 1000),
            .init(name: "Sala", fullAmount: 6000, paidAmount: 3000),
            .init(name: "Content", fullAmount: 2500, paidAmount: 500),
            .init(name: "Kwiaty", fullAmount: 4000, paidAmount: 0),
        ]
    }
}
