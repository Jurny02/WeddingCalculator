//
//  GuestNavigation.swift
//  WeddingCalculator
//
//  Created by Bartosz Jurczyk on 16/08/2025.
//

import Foundation

enum GuestNavigation: Hashable {
    case addGuest
    case guestDetail(GuestModel)
    case editGuest(GuestModel)
    
    var id: String {
        switch self {
        case .addGuest:
            return "addGuest"
        case .guestDetail(let guest):
            return "guestDetail_\(guest.id)"
        case .editGuest(let guest):
            return "editGuest_\(guest.id)"
        }
    }
    
    // Hashable conformance
    func hash(into hasher: inout Hasher) {
        switch self {
        case .addGuest:
            hasher.combine("addGuest")
        case .guestDetail(let guest):
            hasher.combine("guestDetail")
            hasher.combine(guest.id)
        case .editGuest(let guest):
            hasher.combine("editGuest")
            hasher.combine(guest.id)
        }
    }
    
    // Equatable conformance
    static func == (lhs: GuestNavigation, rhs: GuestNavigation) -> Bool {
        switch (lhs, rhs) {
        case (.addGuest, .addGuest):
            return true
        case (.guestDetail(let lhsGuest), .guestDetail(let rhsGuest)):
            return lhsGuest.id == rhsGuest.id
        case (.editGuest(let lhsGuest), .editGuest(let rhsGuest)):
            return lhsGuest.id == rhsGuest.id
        default:
            return false
        }
    }
}
