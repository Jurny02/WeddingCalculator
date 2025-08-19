//
//  GuestDetailView.swift
//  WeddingCalculator
//
//  Created by Bartosz Jurczyk on 16/08/2025.
//

import SwiftUI

struct GuestDetailView: View {
    let guest: GuestModel
    @Binding var guestList: [GuestModel]
    @EnvironmentObject private var navigationManager: NavigationManager<GuestNavigation>
    @State private var showingDeleteAlert = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Header Section
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
                
                // Details Section
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
                
                // Summary Card
                VStack(spacing: 12) {
                    Text("Summary")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    
                    HStack(spacing: 20) {
                        VStack {
                            Text("\(guest.numberOfGuests)")
                                .font(.title)
                                .fontWeight(.bold)
                            Text("Total Guests")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        
                        Divider()
                            .frame(height: 40)
                        
                        VStack {
                            Text(guest.confirmed ? "✓" : "?")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(guest.confirmed ? .green : .orange)
                            Text("Status")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .padding(.horizontal)
                
                // Action Buttons
                VStack(spacing: 16) {
                    Button(action: {
                        navigationManager.navigate(to: .editGuest(guest))
                    }) {
                        HStack {
                            Image(systemName: "pencil")
                            Text("Edit Guest")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
        .navigationTitle("Guest Details")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    showingDeleteAlert = true
                }) {
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                }
            }
        }
        .alert("Delete Guest", isPresented: $showingDeleteAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) {
                deleteGuest()
            }
        } message: {
            Text("Are you sure you want to delete \(guest.name)? This action cannot be undone.")
        }
    }
    
    private func deleteGuest() {
        if let index = guestList.firstIndex(where: { $0.id == guest.id }) {
            guestList.remove(at: index)
            navigationManager.navigateToRoot()
        }
    }
}

#Preview {
    NavigationStack {
        GuestDetailView(guest: GuestModel.fakeData[0], guestList: .constant(GuestModel.fakeData))
    }
    .environmentObject(NavigationManager<GuestNavigation>())
}
