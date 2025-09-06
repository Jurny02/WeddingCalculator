import SwiftUI

struct WeddingSavingsCalculatorView: View {
    private enum FocusedField: Hashable {
        case currentSavings
        case currentSavingsEUR
        case groomMonthly
        case brideMonthly
    }
    @State private var calculatorManager = CalculatorManager()
    @FocusState private var focusedField: FocusedField?
    @Environment(SnackbarManager.self) private var snackbarManager

    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    weddingDate
                    currentSavings
                    monthlySavings
                    savedAmount
                }

                Button("Load data") {
                    do throws (CalculatorManager.CMError) {
                        try calculatorManager.getData()
                        snackbarManager.show(.success(message: "Loading successful"))
                    } catch {
                         handleDataError(error)
                    }
                }
                .padding(.horizontal)
                .buttonStyle(.secondary)

                Button("Save data") {
                    do throws (CalculatorManager.CMError) {
                        try calculatorManager.save()
                        snackbarManager.show(.success(message: "Saving successful"))
                    } catch {
                        handleDataError(error)
                    }
                }
                .padding(.horizontal)
                .buttonStyle(.primary)
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
        }
    }

    private var weddingDate: some View {
        Section(header: Text("Wedding date")) {
            DatePicker("Pick a date", selection: $calculatorManager.calculatorState.weddingDate, displayedComponents: .date)
                .datePickerStyle(.compact)

            Text("Time left: **\(calculatorManager.calculatorState.monthsUntilWedding)** months")
                .foregroundColor(.secondary)
        }
    }

    private var currentSavings: some View {
        Section(header: Text("Current savings")) {
            HStack {
                Text("Saved amount")
                    .padding(.trailing)
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
                    .padding(.trailing)
                TextField(
                    "0",
                    value: $calculatorManager.calculatorState.currentSavingsEUR,
                    format: .currency(code: "EUR")
                )
                .textFieldStyle(CurrencyTextFieldStyle())
                .focused($focusedField, equals: .currentSavingsEUR)

            }
        }
    }

    private var monthlySavings: some View {
        Section(header: Text("Monthly saving")) {
            HStack {
                Text("Groom")
                    .padding(.trailing)
                TextField(
                    "0",
                    value: $calculatorManager.calculatorState.groomMonthly,
                    format: .currency(code: "PLN")
                )
                .textFieldStyle(CurrencyTextFieldStyle())
                .focused($focusedField, equals: .groomMonthly)
            }

            HStack {
                Text("Bride")
                    .padding(.trailing)
                TextField(
                    "0",
                    value: $calculatorManager.calculatorState.brideMonthly,
                    format: .currency(code: "PLN")
                )
                .textFieldStyle(CurrencyTextFieldStyle())
                .focused($focusedField, equals: .brideMonthly)
            }
        }
    }

    private var savedAmount: some View {
        Section {
            HStack {
                Text("Saved amount")
                    .font(.headline)
                Spacer()
                Text(
                    calculatorManager.calculatorState.totalAtWedding,
                    format: .currency(code: "PLN")
                )
                .font(.headline)
                .foregroundColor(.green)
            }
        }
    }

    private func handleDataError(_ error: CalculatorManager.CMError) {
        switch error {
        case .saveFailed:
            snackbarManager.show(.error(message: "Saving data failed"))
        case .loadFailed:
            snackbarManager.show(.error(message: "Loading data failed"))
        }
    }
}

struct WeddingSavingsCalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            WeddingSavingsCalculatorView()
                .environment(SnackbarManager())
        }
    }
}
