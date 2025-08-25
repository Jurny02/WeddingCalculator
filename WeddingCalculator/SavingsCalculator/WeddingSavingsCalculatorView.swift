import SwiftUI

struct WeddingSavingsCalculatorView: View {
    @State private var calculatorState = CalculatorState()
    
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
                                .focused($focusedField, equals: .currentSavings)
                                .submitLabel(.done)
                        }
                        
                        HStack {
                            Text("Zebrana kwota w euro")
                            Spacer()
                            TextField("0", value: $calculatorState.currentSavingsEUR, format: .currency(code: "EUR"))
                                .keyboardType(.decimalPad)
                                .multilineTextAlignment(.trailing)
                                .focused($focusedField, equals: .currentSavingsEUR)
                                .submitLabel(.done)
                        }
                    }
                    
                    Section(header: Text("Miesięczne odkładanie")) {
                        HStack {
                            Text("Pan młody")
                            Spacer()
                            TextField("0", value: $calculatorState.groomMonthly, format: .currency(code: "PLN"))
                                .keyboardType(.decimalPad)
                                .multilineTextAlignment(.trailing)
                                .focused($focusedField, equals: .groomMonthly)
                                .submitLabel(.done)
                        }
                        HStack {
                            Text("Pani młoda")
                            Spacer()
                            TextField("0", value: $calculatorState.brideMonthly, format: .currency(code: "PLN"))
                                .keyboardType(.decimalPad)
                                .multilineTextAlignment(.trailing)
                                .focused($focusedField, equals: .brideMonthly)
                                .submitLabel(.done)
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
                }
                Button("Zapisz dane") {
                    calculatorState.save()
                }
                .buttonStyle(.bordered)
                .padding()
            }
           
            .navigationTitle("Kalkulator oszczędności")
            .navigationBarTitleDisplayMode(.inline)
            .simultaneousGesture(TapGesture().onEnded { focusedField = nil })
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Gotowe") { focusedField = nil }
                }
            }
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
