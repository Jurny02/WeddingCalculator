//
//  GuestListManager.swift
//  WeddingCalculator
//
//  Created by Bartosz Jurczyk on 16/08/2025.
//

import Foundation

@MainActor
class GuestListManager: ObservableObject {
    @Published var guestList: [GuestModel] = GuestModel.fakeData
    
    func addGuest(_ guest: GuestModel) {
        guestList.append(guest)
    }
    
    func updateGuest(_ guest: GuestModel) {
        if let index = guestList.firstIndex(where: { $0.id == guest.id }) {
            guestList[index] = guest
        }
    }
    
    func deleteGuest(_ guest: GuestModel) {
        if let index = guestList.firstIndex(where: { $0.id == guest.id }) {
            guestList.remove(at: index)
        }
    }
    
    func getFilteredGuests(by filterOption: GuestFilterOption) -> [GuestModel] {
        switch filterOption {
        case .all:
            return guestList
        case .confirmed:
            return guestList.filter { $0.confirmed }
        case .notConfirmed:
            return guestList.filter { !$0.confirmed }
        }
    }
    
    func getSortedGuests(_ guests: [GuestModel], by sortOption: GuestSortOption, direction: SortDirection) -> [GuestModel] {
        let sorted = guests.sorted { first, second in
            let comparison: ComparisonResult
            
            switch sortOption {
            case .name:
                comparison = first.name.localizedCaseInsensitiveCompare(second.name)
            case .country:
                comparison = first.country.localizedCaseInsensitiveCompare(second.country)
            case .count:
                comparison = first.numberOfGuests < second.numberOfGuests ? .orderedAscending : 
                            first.numberOfGuests > second.numberOfGuests ? .orderedDescending : .orderedSame
            }
            
            return direction == .ascending ? comparison == .orderedAscending : comparison == .orderedDescending
        }
        
        return sorted
    }
}

// MARK: - Supporting Enums
enum GuestFilterOption: String, CaseIterable {
    case all = "All"
    case confirmed = "Confirmed"
    case notConfirmed = "Not Confirmed"
}

enum GuestSortOption: String, CaseIterable {
    case name = "Name"
    case country = "Country"
    case count = "Guest Count"
}

enum SortDirection {
    case ascending
    case descending
    
    var icon: String {
        switch self {
        case .ascending:
            return "arrow.up"
        case .descending:
            return "arrow.down"
        }
    }
}

