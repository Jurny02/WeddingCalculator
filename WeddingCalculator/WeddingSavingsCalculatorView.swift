import SwiftUI

struct WeddingSavingsCalculatorView: View {
    @State private var weddingDate: Date = Calendar.current.date(byAdding: .month, value: 6, to: Date()) ?? Date()
    @State private var currentSavings: Double = 0
    @State private var groomMonthly: Double = 0
    @State private var brideMonthly: Double = 0
    
    // Ile miesięcy do ślubu
    var monthsUntilWedding: Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.month], from: Date(), to: weddingDate)
        return max(components.month ?? 0, 0)
    }
    
    // Kwota, która będzie uzbierana do dnia wesela
    var totalAtWedding: Double {
        currentSavings + (Double(monthsUntilWedding) * (groomMonthly + brideMonthly))
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Data ślubu")) {
                    DatePicker("Wybierz datę", selection: $weddingDate, displayedComponents: .date)
                        .datePickerStyle(.compact)
                    
                    Text("Pozostało: **\(monthsUntilWedding)** miesięcy")
                        .foregroundColor(.secondary)
                }
                
                Section(header: Text("Obecne oszczędności")) {
                    HStack {
                        Text("Zebrana kwota")
                        Spacer()
                        TextField("0", value: $currentSavings, format: .currency(code: "PLN"))
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                    }
                }
                
                Section(header: Text("Miesięczne odkładanie")) {
                    HStack {
                        Text("Pan młody")
                        Spacer()
                        TextField("0", value: $groomMonthly, format: .currency(code: "PLN"))
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                    }
                    HStack {
                        Text("Pani młoda")
                        Spacer()
                        TextField("0", value: $brideMonthly, format: .currency(code: "PLN"))
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                    }
                }
                
                Section {
                    HStack {
                        Text("Uzbierana suma do wesela")
                            .font(.headline)
                        Spacer()
                        Text(totalAtWedding, format: .currency(code: "PLN"))
                            .font(.headline)
                            .foregroundColor(.green)
                    }
                }
            }
            .navigationTitle("Kalkulator oszczędności")
        }
    }
}

struct WeddingSavingsCalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        WeddingSavingsCalculatorView()
    }
}
