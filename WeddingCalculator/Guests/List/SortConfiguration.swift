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
    var sortDirection: SortDirection = .ascending
    
    func toggleSortDirection() {
        sortDirection = sortDirection.toggle()
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
    
    func toggle() -> SortDirection {
        switch self {
        case .ascending:
            return .descending
        case .descending:
            return .ascending
        }
    }
}

