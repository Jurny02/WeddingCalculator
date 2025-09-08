//
//  AddCostFields.swift
//  WeddingCalculator
//
//  Created by Bartosz Jurczyk on 08/09/2025.
//

import SwiftUI

struct AddCostFields: View {
    @Binding var newCostModel: NewCostModel
    var body: some View {
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

#Preview {
    @Previewable @State var newCostModel: NewCostModel = .init()
    AddCostFields(newCostModel: $newCostModel)
}
