//
//  CostCell.swift
//  WeddingCalculator
//
//  Created by Bartosz Jurczyk on 19/08/2025.
//

import SwiftUI

struct CostCell: View {
    let cost: Cost
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(cost.name)
                    .font(.headline)
                Spacer()
                Text(cost.fullAmount, format: .currency(code: "PLN"))
            }
            .padding(.bottom, 2)
            
            HStack {
                Text("Zapłacono:")
                    .foregroundColor(.secondary)
                Spacer()
                Text(cost.paidAmount, format: .currency(code: "PLN"))
                    .foregroundColor(.secondary)
            }
            
            HStack {
                Text("Pozostało:")
                    .foregroundColor(.secondary)
                Spacer()
                Text(cost.amountToPay, format: .currency(code: "PLN"))
                    .foregroundColor(.red)
            }
        }
        .padding(.vertical, 4)
    }
}
