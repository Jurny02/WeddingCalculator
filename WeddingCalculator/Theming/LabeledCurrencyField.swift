//
//  CTextField.swift
//  WeddingCalculator
//
//  Created by Bartosz Jurczyk on 02/09/2025.
//

import SwiftUI

struct CurrencyTextFieldStyle: TextFieldStyle {

    // swiftlint:disable identifier_name
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .keyboardType(.decimalPad)
            .multilineTextAlignment(.trailing)
            .submitLabel(.done)
            .padding(.horizontal, 4)
            .frame(maxWidth: .infinity)
    }
    // swiftlint:enable identifier_name
}
