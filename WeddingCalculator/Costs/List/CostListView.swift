import SwiftUI
import SwiftData

struct CostListView: View {
    @Environment(\.modelContext) var context
    @State private var navigationManager = NavigationManager<CostNavigation>()
    @Query(sort: \Cost.fullAmount) private var allCosts: [Cost]

    var totalRemaining: Double {
        allCosts.reduce(0) { $0 + $1.amountToPay }
    }

    var body: some View {
        NavigationStack(path: $navigationManager.navigationPath) {
            VStack(spacing: 0) {
                if allCosts.isEmpty {
                    ContentUnavailableView {
                        Label("No costs", systemImage: "exclamationmark.circle.fill")
                    } description: {
                        Text("Your costs will appear here.")
                    }
                } else {
                    List {
                        ForEach(allCosts) { cost in
                            Button {
                                navigationManager.navigate(to: .costDetail(cost))
                            } label: {
                                CostCell(cost: cost)
                            }
                        }
                        .onDelete { indexSet in
                            for index in indexSet {
                                context.delete(allCosts[index])
                            }
                        }
                    }
                    .listStyle(.insetGrouped)

                    HStack {
                        Text("Total remaining:")
                            .font(.headline)
                        Spacer()
                        Text(totalRemaining, format: .currency(code: "PLN"))
                            .font(.headline)
                            .foregroundColor(.red)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Costs")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        navigationManager.navigate(to: .addCost)
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .navigationDestination(for: CostNavigation.self) { destination in
                switch destination {
                case .addCost:
                    AddCostView()
                case .costDetail(let cost):
                    CostDetailView(cost: cost)
                case .editCost(let cost):
                    EditCostView(cost: cost, initialCost: cost)
                }
            }
        }
        .environment(navigationManager)
    }
}

#Preview {
    CostListView()
        .modelContainer(for: [Cost.self, GuestModel.self])
        .environment(NavigationManager<GuestNavigation>())
}
