import SwiftUI

struct WeddingSavingsCalculatorView: View {
    @State private var calculatorState = CalculatorState()
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Data ślubu")) {
                    DatePicker("Wybierz datę", selection: $calculatorState.weddingDate, displayedComponents: .date)
                        .datePickerStyle(.compact)
                    
                    Text("Pozostało: **\(calculatorState.monthsUntilWedding)** miesięcy")
                        .foregroundColor(.secondary)
                }
                
                Section(header: Text("Obecne oszczędności")) {
                    HStack {
                        Text("Zebrana kwota")
                        Spacer()
                        TextField("0", value: $calculatorState.currentSavings, format: .currency(code: "PLN"))
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    HStack {
                        Text("Zebrana kwota w euro")
                        Spacer()
                        TextField("0", value: $calculatorState.currentSavingsEUR, format: .currency(code: "EUR"))
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                    }
                }
                
                Section(header: Text("Miesięczne odkładanie")) {
                    HStack {
                        Text("Pan młody")
                        Spacer()
                        TextField("0", value: $calculatorState.groomMonthly, format: .currency(code: "PLN"))
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                    }
                    HStack {
                        Text("Pani młoda")
                        Spacer()
                        TextField("0", value: $calculatorState.brideMonthly, format: .currency(code: "PLN"))
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                    }
                }
                
                Section {
                    HStack {
                        Text("Uzbierana suma do wesela")
                            .font(.headline)
                        Spacer()
                        Text(calculatorState.totalAtWedding, format: .currency(code: "PLN"))
                            .font(.headline)
                            .foregroundColor(.green)
                    }
                }
                Section {
                    Button("Zapisz dane") {
                        calculatorState.save()
                    }
                } header: {
                    Text("Save")
                }
            }
            .navigationTitle("Kalkulator oszczędności")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                calculatorState.getData()
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
