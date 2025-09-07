//
//  AddCostView.swift
//  WeddingCalculator
//
//  Created by Bartosz Jurczyk on 19/08/2025.
//

import SwiftUI
import SwiftData

struct AddCostView: View {
    @Environment(SnackbarManager.self) private var snackbarManager
    @Environment(NavigationManager<CostNavigation>.self) private var navigationManager
    @Environment(\.modelContext) var context

    @State private var newCostModel = NewCostModel()

    var body: some View {
        Form {
            textFields

            Section {
                Button("Add cost") {
                    do {
                        try newCostModel.addCostToContext(context: context)
                        navigationManager.navigateBack()
                    } catch {

                    }
                }
                .disabled(newCostModel.isInvalid)
            }
        }
        .navigationTitle("Add cost")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var textFields: some View {
        Section {
            LabeledTextField(
                title: "Cost name: ",
                placeholder: "Name",
                value: $newCostModel.name
            )

            LabeldCurrencyTextField(
                title: "Total amount: ",
                placeholder: "Amount",
                value: $newCostModel.fullAmount
            )

            LabeldCurrencyTextField(
                title: "Total paid: ",
                placeholder: "Paid",
                value: $newCostModel.paidAmount
            )
        }
    }
}

#if DEBUG
#Preview {
    NavigationStack {
        AddCostView()
            .appEnvironment()
    }
}
#endif
