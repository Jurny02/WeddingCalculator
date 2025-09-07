//
//  CostDetailView.swift
//  WeddingCalculator
//
//  Created by Bartosz Jurczyk on 16/08/2025.
//

import SwiftUI

struct CostDetailView: View {
    @Environment(NavigationManager<CostNavigation>.self) private var navigationManager

    let cost: Cost

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                header

                summaryCard

                VStack(spacing: 20) {
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
            }
            .padding(.vertical)
        }
        .navigationTitle("Cost Details")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    navigationManager.navigate(to: .editCost(cost))
                } label: {
                    Image(systemName: "pencil")
                }
            }
        }
    }

    private var header: some View {
        VStack(spacing: 16) {
            Circle()
                .fill(Color.blue)
                .frame(width: 80, height: 80)
                .overlay(
                    Image(systemName: "creditcard.fill")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(.white)
                )
            Text(cost.name)
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            Text(cost.paymentStatusText)
                .font(.title2)
                .foregroundColor(cost.paymentStatusColor)
                .fontWeight(.semibold)
        }
    }

    private var summaryCard: some View {
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
                    Text(cost.paymentProgressString)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(cost.paymentStatusColor)
                    Text("Paid")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .padding(.horizontal)
    }
}

#Preview {
    NavigationStack {
        VStack {
            CostDetailView(cost: .init(name: "DJ", fullAmount: 10, paidAmount: 9))
                .appEnvironment()
        }
    }
}
