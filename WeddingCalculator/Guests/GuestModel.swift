//
//  GuestModel.swift
//  WeddingCalculator
//
//  Created by Bartosz Jurczyk on 16/08/2025.
//

import Foundation

struct GuestModel: Identifiable, Hashable {
    let id =  UUID()
    let name: String
    let confirmed: Bool
    let numberOfGuests: Int
    let country: String
    
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
    
    func apply(sortConfig: SortConfiguration) -> Self {
        let filterList = switch sortConfig.filterOption {
        case .all:
            self
        case .confirmed:
             filter { $0.confirmed }
        case .notConfirmed:
            filter { !$0.confirmed }
        }
        
        return switch sortConfig.sortOption {
        case .name:
            filterList.sorted(by: \.name, direction: sortConfig.sortDirection)
        case .country:
            filterList.sorted(by: \.country, direction: sortConfig.sortDirection)
        case .count:
            filterList.sorted(by: \.numberOfGuests, direction: sortConfig.sortDirection)
        }
    }
}
