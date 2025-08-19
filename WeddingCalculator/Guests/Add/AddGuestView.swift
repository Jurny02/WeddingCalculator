//
//  AddGuestView.swift
//  WeddingCalculator
//
//  Created by Bartosz Jurczyk on 16/08/2025.
//

import SwiftUI

struct AddGuestView: View {
    @EnvironmentObject private var guestListManager: GuestListManager
    @EnvironmentObject private var navigationManager: NavigationManager<GuestNavigation>
    
    @State private var name: String = ""
    @State private var numberOfGuests: Int = 1
    @State private var country: String = ""
    @State private var confirmed: Bool = false
    
    var body: some View {
        Form {
            Section("Guest Information") {
                TextField("Name", text: $name)
                
                Stepper("Number of guests: \(numberOfGuests)", value: $numberOfGuests, in: 1...10)
                
                TextField("Country", text: $country)
                
                Toggle("Confirmed", isOn: $confirmed)
            }
            
            Section {
                Button("Add Guest") {
                    addGuest()
                }
                .disabled(name.isEmpty || country.isEmpty)
            }
        }
        .navigationTitle("Add Guest")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Cancel") {
                    navigationManager.navigateToRoot()
                }
            }
        }
    }
    
    private func addGuest() {
        let newGuest = GuestModel(
            name: name,
            confirmed: confirmed,
            numberOfGuests: numberOfGuests,
            country: country
        )
        
        guestListManager.addGuest(newGuest)
        navigationManager.navigateToRoot()
    }
}

#Preview {
    AddGuestView()
        .environmentObject(GuestListManager())
        .environmentObject(NavigationManager<GuestNavigation>())
}
