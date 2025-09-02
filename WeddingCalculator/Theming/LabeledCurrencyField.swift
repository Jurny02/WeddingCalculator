//
//  CTextField.swift
//  WeddingCalculator
//
//  Created by Bartosz Jurczyk on 02/09/2025.
//

import SwiftUI

struct LabeledCurrencyField<Value: BinaryFloatingPoint, FocusField: Hashable>: View {
    @FocusState var focusedField: FocusField?
    @Binding var value: Value
    let label: String
    let currencyCode: String
    let fieldID: FocusField

    var body: some View {
        HStack {
            Text(label)
                .padding(.trailing)
            TextField(
                "0",
                value: $value,
                format: .currency(code: currencyCode)
            )
            .keyboardType(.decimalPad)
            .multilineTextAlignment(.trailing)
            .focused($focusedField, equals: fieldID)
            .submitLabel(.done)
            .frame(maxWidth: .infinity)
        }
    }
}

