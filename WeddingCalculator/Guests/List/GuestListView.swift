//
//  GuestesView.swift
//  WeddingCalculator
//
//  Created by Bartosz Jurczyk on 14/08/2025.
// 

import SwiftUI

struct GuestListView: View {
    @State private var guestListManager = GuestListManager()
    @State private var navigationManager = NavigationManager<GuestNavigation>()
    
    var body: some View {
        NavigationStack(path: $navigationManager.navigationPath) {
            VStack(spacing: 0) {
                if guestListManager.fillterdGuestList.isEmpty {
                    ContentUnavailableView {
                        Label("No Guests", systemImage: "exclamationmark.circle.fill")
                    } description: {
                        Text("New mails you receive will appear here.")
                    }
                } else {
                    filterView
                    
                    List {
                        Section {
                            ForEach(guestListManager.fillterdGuestList) { guest in
                                GuestCell(guest: guest)
                                    .onTapGesture {
                                        navigationManager.navigate(to: .guestDetail(guest))
                                    }
                            }
                        }
                    }
                }
                
                
            }
            .toolbar {
                if !guestListManager.fillterdGuestList.isEmpty {
                    
                    ToolbarItem(placement: .navigationBarLeading) {
                        Menu {
                            Picker("Sort by", selection: $guestListManager.sortConfiguration.sortOption) {
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
                            guestListManager.sortConfiguration.toggleSortDirection()
                        }) {
                            Image(systemName: guestListManager.sortConfiguration.sortDirection.icon)
                                .foregroundColor(.blue)
                        }
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
            .navigationTitle("Guests")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: GuestNavigation.self) { destination in
                viewFor(destination)
            }
            
        }
        .environment(navigationManager)
        .environment(guestListManager)
    }
    
    private var filterView : some View {
        VStack(spacing: 12) {
            // Filter Picker
            Picker("Filter", selection: $guestListManager.sortConfiguration.filterOption) {
                ForEach(GuestFilterOption.allCases, id: \.self) { option in
                    Text(option.rawValue).tag(option)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
            
            // Filter Summary
            HStack {
                Text("Showing \(guestListManager.fillterdGuestList.count) of \(guestListManager.guestList.count) guests")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Spacer()
            }
            .padding(.horizontal)
        }
        .padding(.vertical, 8)
        .background(Color(.systemGray6))
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
}
