//
//  SortConfiguration.swift
//  WeddingCalculator
//
//  Created by Bartosz Jurczyk on 19/08/2025.
//

import SwiftUI

@Observable
class SortConfiguration {
    var filterOption: GuestFilterOption = .all
    var sortOption: GuestSortOption = .name
    var sortDirection: SortOrder = .forward
    
    func toggleSortDirection() {
        sortDirection = sortDirection.toggle()
    }
    
    var sortDescriptor: SortDescriptor<GuestModel> {
        switch sortOption {
        case .name:
            SortDescriptor(\GuestModel.name, order: sortDirection)
        case .country:
            SortDescriptor(\GuestModel.country, order: sortDirection)
        case .count:
            SortDescriptor(\GuestModel.numberOfGuests, order: sortDirection)
        }
    }
    
    var predicate: Predicate<GuestModel> {
        switch filterOption {
        case .all:
            return .true
        case .confirmed:
            return #Predicate<GuestModel> { model in
                model.confirmed
            }
        case .notConfirmed:
            return #Predicate<GuestModel> { model in
                !model.confirmed
            }
        }
    }
}

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

extension SortOrder {
    var icon: String {
        switch self {
        case .forward:
            return "arrow.up"
        case .reverse:
            return "arrow.down"
        }
    }
    
    func toggle() -> SortOrder {
        switch self {
        case .forward:
            return .reverse
        case .reverse:
            return .forward
        }
    }
}
