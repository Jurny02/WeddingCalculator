//
//  GuestesView.swift
//  WeddingCalculator
//
//  Created by Bartosz Jurczyk on 14/08/2025.
//

import SwiftUI

struct GuestesView: View {
    @State private var guestList: [GuestModel] = GuestModel.fakeData
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(guestList) { guest in
                        GuestCell(guest: guest)
                    }
                } header: {
                    Text("In total: \(guestList.getSumOfGuests())")
                }
            }
            .navigationTitle("Guests")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: AddGuestView(guestList: $guestList)) {
                        Image(systemName: "plus")
                            .foregroundColor(.blue)
                    }
                }
            }
        }
    }
}

#Preview {
    GuestesView()
}
