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

            LabeldCurrencyTextField(
                title: "Saved amount in EUR",
                placeholder: "EUR",
                value: $calculatorManager.calculatorState.currentSavingsEUR,
                currencyCode: "EUR"
            )
            .focused($focusedField, equals: .currentSavingsEUR)
        }
    }

    private var monthlySavings: some View {
        Section(header: Text("Monthly saving")) {
            LabeldCurrencyTextField(
                title: "Groom",
                placeholder: "",
                value: $calculatorManager.calculatorState.groomMonthly
            )
            .focused($focusedField, equals: .groomMonthly)

            LabeldCurrencyTextField(
                title: "Bride",
                placeholder: "",
                value: $calculatorManager.calculatorState.brideMonthly
            )
            .focused($focusedField, equals: .brideMonthly)
        }
    }

    private var savedAmount: some View {
        Section {
            LabeldCurrencyTextField(
                title: "Saved amount",
                placeholder: "",
                value: .constant(calculatorManager.calculatorState.totalAtWedding)
            )
        }
    }

    private func handleDataError(_ error: CalculatorManager.CMError) {
        snackbarManager.handle(event: error)
    }
}

#if DEBUG
#Preview {
    NavigationStack {
        WeddingSavingsCalculatorView()
            .appEnvironment()
    }
}
#endif
