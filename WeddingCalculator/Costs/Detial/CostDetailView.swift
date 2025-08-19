//
//  CostDetailView.swift
//  WeddingCalculator
//
//  Created by Bartosz Jurczyk on 16/08/2025.
//

import SwiftUI

struct CostDetailView: View {
    @Environment(NavigationManager<CostNavigation>.self) private var navigationManager
    @Environment(\.modelContext) var context
    @State private var showingDeleteAlert = false
    
    let cost: Cost
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Header Section
                VStack(spacing: 16) {
                    // Cost Icon
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 80, height: 80)
                        .overlay(
                            Image(systemName: "creditcard.fill")
                                .font(.system(size: 40, weight: .bold))
                                .foregroundColor(.white)
                        )
                    
                    // Cost Name
                    Text(cost.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                    
                    // Payment Status
                    Text(paymentStatusText)
                        .font(.title2)
                        .foregroundColor(paymentStatusColor)
                        .fontWeight(.semibold)
                }
                
                // Details Section
                VStack(spacing: 20) {
                    DetailRow(
                        icon: "creditcard.fill",
                        title: "Full Amount",
                        value: cost.fullAmount.formatted(.currency(code: "PLN"))
                    )
                    
                    DetailRow(
                        icon: "checkmark.circle.fill",
                        title: "Paid Amount",
                        value: cost.paidAmount.formatted(.currency(code: "PLN"))
                    )
                    
                    DetailRow(
                        icon: "exclamationmark.circle.fill",
                        title: "Remaining to Pay",
                        value: cost.amountToPay.formatted(.currency(code: "PLN"))
                    )
                }
                .padding(.horizontal)
                
                // Summary Card
                VStack(spacing: 12) {
                    Text("Payment Summary")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    
                    HStack(spacing: 20) {
                        VStack {
                            Text(cost.fullAmount.formatted(.currency(code: "PLN")))
                                .font(.title)
                                .fontWeight(.bold)
                            Text("Total Cost")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        
                        Divider()
                            .frame(height: 40)
                        
                        VStack {
                            Text("\(Int((cost.paidAmount / cost.fullAmount) * 100))%")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(paymentStatusColor)
                            Text("Paid")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .padding(.horizontal)
                
                // Progress Bar
                VStack(spacing: 8) {
                    HStack {
                        Text("Payment Progress")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        Spacer()
                        Text("\(cost.paidAmount.formatted(.currency(code: "PLN"))) / \(cost.fullAmount.formatted(.currency(code: "PLN")))")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    ProgressView(value: cost.paidAmount, total: cost.fullAmount)
                        .progressViewStyle(LinearProgressViewStyle(tint: paymentStatusColor))
                        .scaleEffect(x: 1, y: 2, anchor: .center)
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
        .navigationTitle("Cost Details")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    navigationManager.navigate(to: .editCost(cost))
                }) {
                    Image(systemName: "pencil")
                }
            }
        }
    }

    private var paymentStatusText: String {
        if cost.amountToPay == 0 {
            return "Fully Paid"
        } else if cost.paidAmount == 0 {
            return "Not Paid"
        } else {
            return "Partially Paid"
        }
    }
    
    private var paymentStatusColor: Color {
        if cost.amountToPay == 0 {
            return .green
        } else if cost.paidAmount == 0 {
            return .red
        } else {
            return .orange
        }
    }
}

#Preview {
    NavigationStack {
        CostDetailView(cost: .fakeData)
    }
}
