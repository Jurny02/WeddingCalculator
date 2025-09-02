import SwiftUI

struct WeddingSavingsCalculatorView: View {
    @State private var calculatorManager = CalculatorManager()
    @FocusState private var focusedField: FocusedField?
    private enum FocusedField: Hashable {
        case currentSavings
        case currentSavingsEUR
        case groomMonthly
        case brideMonthly
    }


    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section(header: Text("Wedding date")) {
                        DatePicker("Pick a date", selection: $calculatorManager.calculatorState.weddingDate, displayedComponents: .date)
                            .datePickerStyle(.compact)

                        Text("Time left: **\(calculatorManager.calculatorState.monthsUntilWedding)** months")
                            .foregroundColor(.secondary)
                    }

                    Section(header: Text("Current savings")) {
                        HStack {
                            Text("Saved amount")
                            Spacer()
                            TextField(
                                "0",
                                value: $calculatorManager.calculatorState.currentSavings,
                                format: .currency(code: "PLN")
                            )
                                .keyboardType(.decimalPad)
                                .multilineTextAlignment(.trailing)
                                .focused($focusedField, equals: .currentSavings)
                                .submitLabel(.done)
                        }

                        HStack {
                            Text("Saved amount in EUR")
                            Spacer()
                            TextField(
                                "0",
                                value: $calculatorManager.calculatorState.currentSavingsEUR,
                                format: .currency(code: "EUR")
                            )
                                .keyboardType(.decimalPad)
                                .multilineTextAlignment(.trailing)
                                .focused($focusedField, equals: .currentSavingsEUR)
                                .submitLabel(.done)
                        }
                    }

                    Section(header: Text("Monthly saving")) {
//                        LabeledCurrencyField(
//                            value: $calculatorManager.calculatorState.groomMonthly,
//                            label: "Groom",
//                            currencyCode: "PLN",
//                            fieldID: focusedField
//                        )
                        HStack {
                            Text("Groom")
                            Spacer()
                            TextField(
                                "0",
                                value: $calculatorManager.calculatorState.groomMonthly,
                                format: .currency(code: "PLN")
                            )
                                .keyboardType(.decimalPad)
                                .multilineTextAlignment(.trailing)
                                .focused($focusedField, equals: .groomMonthly)
                                .submitLabel(.done)
                        }
                        HStack {
                            Text("Bride")
                            Spacer()
                            TextField(
                                "0",
                                value: $calculatorManager.calculatorState.brideMonthly,
                                format: .currency(code: "PLN")
                            )
                                .keyboardType(.decimalPad)
                                .multilineTextAlignment(.trailing)
                                .focused($focusedField, equals: .brideMonthly)
                                .submitLabel(.done)
                        }
                    }

                    Section {
                        HStack {
                            Text("Saved amount")
                                .font(.headline)
                            Spacer()
                            Text(calculatorState.totalAtWedding, format: .currency(code: "PLN"))
                                .font(.headline)
                                .foregroundColor(.green)
                        }
                    }
                }
                Button("Save data") {
//                    do {
//                        try calculatorState.save()
//                    } catch {
//                    }
                }
                .buttonStyle(.bordered)
                .padding()
            }
            .navigationTitle("Savings calculator")
            .navigationBarTitleDisplayMode(.inline)
            .simultaneousGesture(TapGesture().onEnded { focusedField = nil })
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") { focusedField = nil }
                }
            }
            .onAppear {
//                calculatorState.getData()
            }
        }
    }
}

struct WeddingSavingsCalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            WeddingSavingsCalculatorView()
        }
    }
}
