import SwiftUI

struct CostListView: View {
    @State private var costs: [Cost] = .fakeData
    
    var totalRemaining: Double {
        costs.reduce(0) { $0 + $1.amountToPay }
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                List {
                    ForEach(costs) { cost in
                        NavigationLink {
                            // Zielony placeholder
                            Color.green
                                .ignoresSafeArea()
                                .navigationTitle(cost.name)
                        } label: {
                            VStack(alignment: .leading) {
                                HStack {
                                    Text(cost.name)
                                        .font(.headline)
                                    Spacer()
                                    Text(cost.fullAmount, format: .currency(code: "PLN"))
                                }
                                .padding(.bottom, 2)
                                
                                HStack {
                                    Text("Zapłacono:")
                                        .foregroundColor(.secondary)
                                    Spacer()
                                    Text(cost.paidAmount, format: .currency(code: "PLN"))
                                        .foregroundColor(.secondary)
                                }
                                
                                HStack {
                                    Text("Pozostało:")
                                        .foregroundColor(.secondary)
                                    Spacer()
                                    Text(cost.amountToPay, format: .currency(code: "PLN"))
                                        .foregroundColor(.red)
                                }
                            }
                            .padding(.vertical, 4)
                        }
                    }
                    .onDelete(perform: deleteCost)
                }
                .listStyle(.insetGrouped)
                
                // Suma pozostała do zapłaty
                HStack {
                    Text("Suma do zapłaty:")
                        .font(.headline)
                    Spacer()
                    Text(totalRemaining, format: .currency(code: "PLN"))
                        .font(.headline)
                        .foregroundColor(.red)
                }
                .padding()
                .background(Color(.systemGray6))
            }
            .navigationTitle("Wydatki")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        // Tutaj otwierasz nowy widok dodawania kosztu
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
    
    private func deleteCost(at offsets: IndexSet) {
        costs.remove(atOffsets: offsets)
    }
}

struct CostListView_Previews: PreviewProvider {
    static var previews: some View {
        CostListView()
    }
}
