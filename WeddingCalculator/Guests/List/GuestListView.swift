//
//  GuestesView.swift
//  WeddingCalculator
//
//  Created by Bartosz Jurczyk on 14/08/2025.
//

import SwiftUI

struct GuestListView: View {
    @StateObject private var guestListManager = GuestListManager()
    @StateObject private var navigationManager = NavigationManager<GuestNavigation>()
    @State private var filterOption: GuestFilterOption = .all
    @State private var sortOption: GuestSortOption = .name
    @State private var sortDirection: SortDirection = .ascending
    
    var filteredAndSortedGuestList: [GuestModel] {
        let filtered = guestListManager.getFilteredGuests(by: filterOption)
        return guestListManager.getSortedGuests(filtered, by: sortOption, direction: sortDirection)
    }
    
    var body: some View {
        NavigationStack(path: $navigationManager.navigationPath) {
            VStack(spacing: 0) {
                // Filter Section
                VStack(spacing: 12) {
                    // Filter Picker
                    Picker("Filter", selection: $filterOption) {
                        ForEach(GuestFilterOption.allCases, id: \.self) { option in
                            Text(option.rawValue).tag(option)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal)
                    
                    // Filter Summary
                    HStack {
                        Text("Showing \(filteredAndSortedGuestList.count) of \(guestListManager.guestList.count) guests")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        Spacer()
                        
                        Text("Total: \(filteredAndSortedGuestList.getSumOfGuests())")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical, 8)
                .background(Color(.systemGray6))
                
                // Guest List
                List {
                    Section {
                        ForEach(filteredAndSortedGuestList) { guest in
                            GuestCell(guest: guest)
                                .onTapGesture {
                                    navigationManager.navigate(to: .guestDetail(guest))
                                }
                        }
                    }
                }
            }
            .navigationTitle("Guests")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Menu {
                        Picker("Sort by", selection: $sortOption) {
                            ForEach(GuestSortOption.allCases, id: \.self) { option in
                                Label(option.rawValue, systemImage: sortIcon(for: option))
                                    .tag(option)
                            }
                        }
                    } label: {
                        Image(systemName: "arrow.up.arrow.down")
                            .foregroundColor(.blue)
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        sortDirection = sortDirection == .ascending ? .descending : .ascending
                    }) {
                        Image(systemName: sortDirection.icon)
                            .foregroundColor(.blue)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        navigationManager.navigate(to: .addGuest)
                    }) {
                        Image(systemName: "plus")
                            .foregroundColor(.blue)
                    }
                }
            }
            .navigationDestination(for: GuestNavigation.self) { destination in
                
            }
        }
        .environmentObject(navigationManager)
        .environmentObject(guestListManager)
    }
    
    private func sortIcon(for option: GuestSortOption) -> String {
        switch option {
        case .name:
            return "textformat"
        case .country:
            return "flag"
        case .count:
            return "person.2"
        }
    }
    
    func viewFor(_ destination: GuestNavigation) {
        switch destination {
        case .addGuest:
            AddGuestView()
        case .guestDetail(let guest):
            GuestDetailView(guest: guest, guestList: $guestListManager.guestList)
        case .editGuest(let guest):
            EditGuestView(guest: guest)
        }
    }
}

#Preview {
    GuestListView()
        .environmentObject(NavigationManager<GuestNavigation>())
}
