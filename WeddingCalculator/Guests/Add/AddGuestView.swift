//
//  AddGuestView.swift
//  WeddingCalculator
//
//  Created by Bartosz Jurczyk on 16/08/2025.
//

import SwiftUI

struct AddGuestView: View {
    @Environment(SnackbarManager.self) var snackbarManager
    @Environment(NavigationManager<GuestNavigation>.self) private var navigationManager
    @Environment(\.modelContext) var context
    @State private var newGuestModel = NewGuestModel()

    var body: some View {
        Form {
            Section("Guest Information") {
                TextField("Name", text: $newGuestModel.name)

                Stepper("Number of guests: \(newGuestModel.numberOfGuests)", value: $newGuestModel.numberOfGuests, in: 1...10)

                TextField("Country", text: $newGuestModel.country)

                Toggle("Confirmed", isOn: $newGuestModel.confirmed)
            }

            Section {
                Button("Add Guest") {
                    do throws(NewGuestModel.NGMError) {
                        try newGuestModel.addGuest(to: context)
                        navigationManager.navigateBack()
                    } catch {
                        snackbarManager.handle(event: error)
                    }
                }
                .disabled(newGuestModel.isInvalid)
            }
        }
        .navigationTitle("Add Guest")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        AddGuestView()
            .appEnvironment()
    }
}
