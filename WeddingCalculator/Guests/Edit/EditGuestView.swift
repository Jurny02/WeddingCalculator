//
//  EditGuestView.swift
//  WeddingCalculator
//
//  Created by Bartosz Jurczyk on 16/08/2025.
//

import SwiftUI
import SwiftData

struct EditGuestView: View {
    @Environment(NavigationManager<GuestNavigation>.self) private var navigationManager
    @Environment(\.modelContext) var context
    @Bindable var guest: GuestModel
    
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
    
    private var saveButtonDisabled: Bool {
        name.isEmpty || country.isEmpty || hasNoChanges
    }
    
    init(guest: GuestModel) {
        _guest = Bindable(guest)
        
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
                .disabled(saveButtonDisabled)
            }
        }
        .navigationTitle("Edit Guest")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Cancel") {
                    navigationManager.navigateBack()
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
        guest.confirmed = confirmed
        guest.name = name
        guest.numberOfGuests = numberOfGuests
        guest.country = country
        navigationManager.navigateToRoot()
    }
}

//#Preview {
//    EditGuestView(guest: .init(GuestModel.fakeData[0]))
//        .environment(NavigationManager<GuestNavigation>())
//}
