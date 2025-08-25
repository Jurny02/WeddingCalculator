//
//  GuestModel.swift
//  WeddingCalculator
//
//  Created by Bartosz Jurczyk on 16/08/2025.
//

import Foundation
import SwiftData

@Model
class GuestModel: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var confirmed: Bool
    var numberOfGuests: Int
    var country: String
    
    init(name: String, confirmed: Bool, numberOfGuests: Int, country: String) {
        self.name = name
        self.confirmed = confirmed
        self.numberOfGuests = numberOfGuests
        self.country = country
    }
    
    static var fakeData: [GuestModel] = [
        GuestModel(name: "Anna Kowalska", confirmed: true, numberOfGuests: 2, country: "Poland"),
        GuestModel(name: "John Smith", confirmed: false, numberOfGuests: 1, country: "United Kingdom"),
        GuestModel(name: "Maria Rossi", confirmed: true, numberOfGuests: 3, country: "Italy"),
        GuestModel(name: "Carlos Hernandez", confirmed: true, numberOfGuests: 4, country: "Spain"),
        GuestModel(name: "Sophie Dubois", confirmed: false, numberOfGuests: 2, country: "France"),
        GuestModel(name: "Liam O'Connor", confirmed: true, numberOfGuests: 1, country: "Ireland"),
        GuestModel(name: "Yuki Tanaka", confirmed: false, numberOfGuests: 2, country: "Japan")
    ]
}

extension [GuestModel] {
    func sumOfGuests(guestFilterOption: GuestFilterOption) -> Int {
        filter {
            switch guestFilterOption {
            case .all:
                true
            case .confirmed:
                $0.confirmed
            case .notConfirmed:
                $0.confirmed == false
            }
        }.reduce(0) { partialResult, guest in
            partialResult + guest.numberOfGuests
        }
    }
}

