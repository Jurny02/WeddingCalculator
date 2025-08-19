//
//  CostsView.swift
//  WeddingCalculator
//
//  Created by Bartosz Jurczyk on 14/08/2025.
//

import SwiftUI

struct CostsView: View {
    let costs: [Cost] = .fakeData
    var body: some View {
        List(costs) { cost in
            CostCell(cost: cost)
        }
        .navigationTitle("Wydatki")
    }
}

#Preview {
    NavigationStack {
        CostsView()
    }
}

struct CostCell: View {
    var cost: Cost
    
    var body: some View {
        HStack {
            Text(cost.name)
            Spacer()
            Text("\(cost.amountToPay.formatted(.currency(code: "PLN")))")
        }
    }
}

struct Cost: Identifiable {
    
    let id: UUID = UUID()
    let name: String
    let fullAmount: Double
    let paidAmount: Double
    
    var amountToPay: Double {
        fullAmount - paidAmount
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
