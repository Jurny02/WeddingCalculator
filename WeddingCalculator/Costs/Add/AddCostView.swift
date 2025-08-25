//
//  AddCostView.swift
//  WeddingCalculator
//
//  Created by Bartosz Jurczyk on 19/08/2025.
//

import SwiftUI
import SwiftData

struct AddCostView: View {
    @Environment(NavigationManager<CostNavigation>.self) private var navigationManager
    @Environment(\.modelContext) var context
    
    @State private var name: String = ""
    @State private var fullAmount: Double = 0
    @State private var paidAmount: Double = 0
    
    private var amountToPay: Double { max(fullAmount - paidAmount, 0) }
    
    private var isInvalid: Bool {
        name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
        fullAmount < 0 ||
        paidAmount < 0 ||
        paidAmount > fullAmount
    }
    
    var body: some View {
        Form {
            Section("Nazwa") {
                TextField("", text: $name)
            }
            
            Section("Kwota całkowita") {
                TextField("", value: $fullAmount, format: .currency(code: "PLN"))
                    .keyboardType(.decimalPad)
            }
            
            Section("Zapłacono") {
                TextField("", value: $paidAmount, format: .currency(code: "PLN"))
                    .keyboardType(.decimalPad)
            }
            
            Section {
                Button("Dodaj koszt") {
                    let newCost = Cost(name: name.trimmingCharacters(in: .whitespacesAndNewlines), fullAmount: fullAmount, paidAmount: paidAmount)
                    context.insert(newCost)
                }
                .disabled(isInvalid)
            }
        }
        .navigationTitle("Dodaj koszt")
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
        AddCostView()
            .modelContainer(for: [Cost.self, GuestModel.self])
            .environment(NavigationManager<GuestNavigation>())
    }
}


