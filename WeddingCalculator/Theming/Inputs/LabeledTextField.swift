//
//  LabeledTextField.swift
//  WeddingCalculator
//
//  Created by Bartosz Jurczyk on 06/09/2025.
//

import SwiftUI

struct LabeledTextField: View {
    let title: String
    let placeholder: String
    @Binding var value: String
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            TextField(placeholder, text: $value)
                .padding(.leading)
                .multilineTextAlignment(.trailing)
        }
    }
}

#Preview {
    @Previewable @State var name: String = ""
    LabeledTextField(title: "SOme", placeholder: "Test", value: $name)
}
