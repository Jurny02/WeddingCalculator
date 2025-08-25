//
//  GuestesView.swift
//  WeddingCalculator
//
//  Created by Bartosz Jurczyk on 14/08/2025.
//

import SwiftUI

struct GuestListView: View {
    @State private var navigationManager = NavigationManager<GuestNavigation>()
    @State private var sortConfiguration = SortConfiguration()
    
    var body: some View {
        NavigationStack(path: $navigationManager.navigationPath) {
            GuestListQuery(sortConfiguation: $sortConfiguration)
                .navigationTitle("Guests")
                .navigationBarTitleDisplayMode(.inline)
                .navigationDestination(for: GuestNavigation.self) { destination in
                    viewFor(destination)
                }
        }
        .environment(navigationManager)
    }
    
    func viewFor(_ destination: GuestNavigation) -> some View {
        ZStack {
            switch destination {
            case .addGuest:
                AddGuestView()
            case .guestDetail(let guest):
                GuestDetailView(guest: guest)
            case .editGuest(let guest):
                EditGuestView(guest: guest)
            }
        }
    }
}

#Preview {
    GuestListView()
        .environment(NavigationManager<GuestNavigation>())
        .modelContainer(for: [Cost.self, GuestModel.self])
}
