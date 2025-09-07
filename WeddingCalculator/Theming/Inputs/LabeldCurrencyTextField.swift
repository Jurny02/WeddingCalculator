//
//  LabeldCurrencyTextField.swift
//  WeddingCalculator
//
//  Created by Bartosz Jurczyk on 06/09/2025.
//

import SwiftUI

struct LabeldCurrencyTextField: View {
    let title: String
    let placeholder: String
    @Binding var value: Double
    let currencyCode: String

    init(title: String, placeholder: String, value: Binding<Double>, currencyCode: String = "PLN") {
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
                .multilineTextAlignment(.trailing)
                .submitLabel(.done)
                .padding(.horizontal, 4)
                .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    @Previewable @State var value: Double = 0
    LabeldCurrencyTextField(
        title: "title: ",
        placeholder: "placeholder",
        value: $value
    )
}
