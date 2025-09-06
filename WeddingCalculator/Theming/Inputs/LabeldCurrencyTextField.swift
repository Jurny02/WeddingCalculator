//
//  LabeldCurrencyTextField.swift
//  WeddingCalculator
//
//  Created by Bartosz Jurczyk on 06/09/2025.
//

import SwiftUI

struct LabeldCurrencyTextField: View {
    @Binding var value: Double
    let placeholder: String
    let title: String
    let currencyCode: String

    init(value: Binding<Double>, placeholder: String, title: String, currencyCode: String = "PLN") {
        _value = value
        self.placeholder = placeholder
        self.title = title
        self.currencyCode = currencyCode
    }
    var body: some View {
        HStack {
            Text(title)
            TextField(placeholder, value: $value, format: .currency(code: currencyCode))
                .keyboardType(.decimalPad)
                .padding(.leading)
        }
    }
}

#Preview {
    @Previewable @State var value: Double = 0
    LabeldCurrencyTextField(
        value: $value,
        placeholder: "placeholder",
        title: "title: "
    )
}
