//
//  EditGuestView.swift
//  WeddingCalculator
//
//  Created by Bartosz Jurczyk on 16/08/2025.
//

import SwiftUI

struct EditGuestView: View {
    let guest: GuestModel
    @EnvironmentObject private var guestListManager: GuestListManager
    @EnvironmentObject private var navigationManager: NavigationManager<GuestNavigation>
    
    @State private var name: String
    @State private var numberOfGuests: Int
    @State private var country: String
    @State private var confirmed: Bool
    
    private var hasNoChanges: Bool {
        name == guest.name &&
        numberOfGuests == guest.numberOfGuests &&
        country == guest.country &&
        confirmed == guest.confirmed
    }
    
    init(guest: GuestModel) {
        self.guest = guest
        
        // Initialize state with current guest values
        self._name = State(initialValue: guest.name)
        self._numberOfGuests = State(initialValue: guest.numberOfGuests)
        self._country = State(initialValue: guest.country)
        self._confirmed = State(initialValue: guest.confirmed)
    }
    
    var body: some View {
        Form {
            Section("Guest Information") {
                TextField("Name", text: $name)
                
                Stepper("Number of guests: \(numberOfGuests)", value: $numberOfGuests, in: 1...10)
                
                TextField("Country", text: $country)
                
                Toggle("Confirmed", isOn: $confirmed)
            }
            
            Section {
                Button("Save Changes") {
                    saveChanges()
                }
                .disabled(name.isEmpty || country.isEmpty || hasNoChanges)
            }
        }
        .navigationTitle("Edit Guest")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Cancel") {
                    navigationManager.navigateToRoot()
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    saveChanges()
                }
                .disabled(name.isEmpty || country.isEmpty || hasNoChanges)
            }
        }
    }
    
    private func saveChanges() {
        let updatedGuest = GuestModel(
            name: name,
            confirmed: confirmed,
            numberOfGuests: numberOfGuests,
            country: country
        )
        
        guestListManager.updateGuest(updatedGuest)
        navigationManager.navigateToRoot()
    }
}

#Preview {
    EditGuestView(guest: GuestModel.fakeData[0])
        .environmentObject(GuestListManager())
        .environmentObject(NavigationManager<GuestNavigation>())
}
