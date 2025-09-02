//
//  EditCostView.swift
//  WeddingCalculator
//
//  Created by Bartosz Jurczyk on 19/08/2025.
//

import SwiftUI

struct EditCostView: View {
    @Bindable var cost: Cost
    let initialCost: Cost

    private var hasNoChanges: Bool {
        cost == initialCost
    }

    private var amountToPay: Double { max(cost.fullAmount - cost.paidAmount, 0) }

    private var isInvalid: Bool {
        cost.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
        cost.fullAmount < 0 ||
        cost.paidAmount < 0 ||
        cost.paidAmount > cost.fullAmount ||
        hasNoChanges
    }

    var body: some View {
        Form {
            Section("Cost information") {
                TextField("Name", text: $cost.name)

                TextField("Total amount", value: $cost.fullAmount, format: .currency(code: "PLN"))
                    .keyboardType(.decimalPad)

                TextField("Paid", value: $cost.paidAmount, format: .currency(code: "PLN"))
                    .keyboardType(.decimalPad)
            }
        }
        .navigationTitle("Edit cost")
        .navigationBarTitleDisplayMode(.inline)
    }
}

private extension DetailRow {
    init(icon: String, title: String, value: Double, format: FloatingPointFormatStyle<Double>) {
        self.init(icon: icon, title: title, value: value.formatted(format))
    }
}

#Preview {
    NavigationStack {
        EditCostView(cost: .fakeData, initialCost: .fakeData)
    }
}
