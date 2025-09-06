//
//  GuestListQuery.swift
//  WeddingCalculator
//
//  Created by Bartosz Jurczyk on 20/08/2025.
//

import SwiftUI
import SwiftData

struct GuestListQuery: View {
    @Environment(NavigationManager<GuestNavigation>.self) private var navigationManager
    @Environment(\.modelContext) var context
    @Query private var guestList: [GuestModel]
    @Query private var allGuestList: [GuestModel]
    @Binding var sortConfiguration: SortConfiguration

    init(sortConfiguation: Binding<SortConfiguration>) {
        let sortValue = sortConfiguation.wrappedValue
        _guestList = Query(
            filter: sortValue.predicate,
            sort: [sortValue.sortDescriptor]
        )
        _sortConfiguration = sortConfiguation
    }

    var body: some View {
        VStack(spacing: .zero) {
            filterView
            List {
                if allGuestList.isEmpty {
                    ContentUnavailableView {
                        Label("No Guests", systemImage: "exclamationmark.circle.fill")
                    } description: {
                        Text("New mails you receive will appear here.")
                    }
                } else {
                    if guestList.isEmpty {
                        ZStack {
                            Text("No result")
                        }
                    } else {
                        Section {
                            ForEach(guestList) { guest in
                                GuestCell(guest: guest)
                                    .onTapGesture {
                                        navigationManager.navigate(to: .guestDetail(guest))
                                    }
                            }
                            .onDelete { indexSet in
                                for index in indexSet {
                                    context.delete(guestList[index])
                                }
                            }
                        }
                    }
                }
            }
        }
        .toolbar {
            if !allGuestList.isEmpty {
                ToolbarItem(placement: .navigationBarLeading) {
                    Menu {
                        Picker("Sort by", selection: $sortConfiguration.sortOption) {
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
                    Button {
                        sortConfiguration.toggleSortDirection()
                    } label: {
                        Image(systemName: sortConfiguration.sortDirection.icon)
                            .foregroundColor(.blue)
                    }
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    navigationManager.navigate(to: .addGuest)
                } label: {
                    Image(systemName: "plus")
                        .foregroundColor(.blue)
                }
            }
        }
    }

    private var filterView: some View {
        VStack(spacing: 12) {
            // Filter Picker
            Picker("Filter", selection: $sortConfiguration.filterOption) {
                ForEach(GuestFilterOption.allCases, id: \.self) { option in
                    Text(option.rawValue).tag(option)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)

            // Filter Summary
            HStack {
                Text("Showing \(guestList.count)/\(allGuestList.count) entries")

                Spacer()

                Text("Showing \(guestList.sumOfGuests(guestFilterOption: sortConfiguration.filterOption))/\(allGuestList.sumOfGuests(guestFilterOption: .all)) of all guests")

            }
            .font(.caption)
            .foregroundColor(.secondary)
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
}

#Preview {
    GuestListView()
        .environment(NavigationManager<GuestNavigation>())
        .modelContainer(for: [Cost.self, GuestModel.self])
}
