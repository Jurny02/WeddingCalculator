//
//  GuestDetailView.swift
//  WeddingCalculator
//
//  Created by Bartosz Jurczyk on 16/08/2025.
//

import SwiftUI

struct GuestDetailView: View {
    @Environment(NavigationManager<GuestNavigation>.self) private var navigationManager
    let guest: GuestModel

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                header

                details

                summaryCard
            }
            .padding(.vertical)
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    navigationManager.navigate(to: .editGuest(guest))
                } label: {
                    Image(systemName: "pencil")
                }
            }
        }
        .navigationTitle("Guest Details")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var header: some View {
        VStack(spacing: 16) {
            // Status Circle
            Circle()
                .fill(guest.confirmed ? Color.green : Color.red)
                .frame(width: 80, height: 80)
                .overlay(
                    Image(systemName: guest.confirmed ? "checkmark" : "xmark")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(.white)
                )

            // Guest Name
            Text(guest.name)
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)

            // Status Text
            Text(guest.confirmed ? "Confirmed" : "Not Confirmed")
                .font(.title2)
                .foregroundColor(guest.confirmed ? .green : .red)
                .fontWeight(.semibold)
        }
    }

    private var details: some View {
        VStack(spacing: 20) {
            DetailRow(
                icon: "person.2.fill",
                title: "Number of Guests",
                value: "\(guest.numberOfGuests) guest\(guest.numberOfGuests > 1 ? "s" : "")"
            )

            DetailRow(
                icon: "flag.fill",
                title: "Country",
                value: guest.country
            )

            DetailRow(
                icon: "calendar.badge.clock",
                title: "Response Status",
                value: guest.confirmed ? "Responded" : "Awaiting Response"
            )
        }
        .padding(.horizontal)
    }

    private var summaryCard: some View {
        VStack(spacing: 12) {
            Text("Summary")
                .font(.headline)
                .foregroundColor(.secondary)

            HStack(spacing: 20) {
                Spacer()
                VStack {
                    Text("\(guest.numberOfGuests)")
                        .font(.title)
                        .fontWeight(.bold)
                    Text("Total Guests")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                Spacer()
                Divider()
                    .frame(height: 40)
                Spacer()
                VStack {
                    Text(guest.confirmed ? "✓" : "?")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(guest.confirmed ? .green : .orange)
                    Text("Status")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                Spacer()
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
        GuestDetailView(guest: GuestModel.fakeData[0])
            .appEnvironment()
    }

}
