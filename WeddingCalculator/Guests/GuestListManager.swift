//
//  GuestListManager.swift
//  WeddingCalculator
//
//  Created by Bartosz Jurczyk on 16/08/2025.
//

import Foundation

@Observable
class GuestListManager {
    private var _guestList: [GuestModel] = GuestModel.fakeData
    var sortConfiguration = SortConfiguration()
    
    var guestList: [GuestModel] {
        _guestList
    }
    
    var fillterdGuestList: [GuestModel] {
        _guestList.apply(sortConfig: sortConfiguration)
    }
    
    func addGuest(_ guest: GuestModel) {
        _guestList.append(guest)
    }
    
    func updateGuest(_ guest: GuestModel) {
        if let index = _guestList.firstIndex(where: { $0.id == guest.id }) {
            _guestList[index] = guest
        }
    }
    
    func deleteGuest(_ guest: GuestModel) {
        if let index = _guestList.firstIndex(where: { $0.id == guest.id }) {
            _guestList.remove(at: index)
        }
    }
}
