//
//  LabeledTextField.swift
//  WeddingCalculator
//
//  Created by Bartosz Jurczyk on 06/09/2025.
//

import SwiftUI

struct LabeledTextField: View {
    @Binding var name: String
    let title: String
    let placeholder: String
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            TextField(placeholder, text: $name)
                .padding(.leading)
        }
    }
}

#Preview {
    @Previewable @State var name: String = ""
    LabeledTextField(name: $name, title: "Test", placeholder: "SOme")
}
