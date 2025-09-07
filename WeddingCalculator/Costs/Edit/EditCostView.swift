//
//  EditCostView.swift
//  WeddingCalculator
//
//  Created by Bartosz Jurczyk on 19/08/2025.
//

import SwiftUI

struct EditCostView: View {
    @Environment(NavigationManager<CostNavigation>.self) private var navigationManager
    @Bindable var cost: Cost
    @State private var newCostModel: NewCostModel

    init(cost: Cost) {
        _cost = .init(cost)
        self.newCostModel = .init(form: cost)
    }

    var body: some View {
        Form {
            Section("Cost information") {
                LabeledTextField(
                    title: "Name",
                    placeholder: "Name",
                    value: $newCostModel.name
                )

                LabeldCurrencyTextField(
                    title: "Total amount",
                    placeholder: "Total amount",
                    value: $newCostModel.fullAmount
                )

                LabeldCurrencyTextField(
                    title: "Paid",
                    placeholder: "Paid",
                    value: $newCostModel.paidAmount
                )
            }

            Button("Save") {
                cost.update(with: newCostModel)
                navigationManager.navigateBack()
            }
            .disabled(newCostModel.isInvalid)

            Button("Reload") {
                newCostModel = .init(form: cost)
            }

        }
        .navigationTitle("Edit cost")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#if DEBUG
#Preview {
    NavigationStack {
        EditCostView(cost: .fakeData)
            .appEnvironment()
    }
}
#endif
