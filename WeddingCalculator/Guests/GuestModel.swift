//
//  GuestModel.swift
//  WeddingCalculator
//
//  Created by Bartosz Jurczyk on 16/08/2025.
//

import Foundation

struct GuestModel: Identifiable, Hashable {
    var id: Int {
        self.hashValue
    }
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
        GuestModel(name: "Yuki Tanaka", confirmed: false, numberOfGuests: 2, country: "Japan"),
        GuestModel(name: "Anna Kowalska", confirmed: true, numberOfGuests: 2, country: "Poland")
    ]
}

extension [GuestModel] {
    func getSumOfGuests(onlyConfirmed: Bool = false) -> Int {
        let searchedArray: [GuestModel] = onlyConfirmed ? filter(\.confirmed) : self
        return searchedArray.reduce(0) { partialResult, nextElement in
            partialResult + nextElement.numberOfGuests
        }
    }
    
    func sort(by sortOption: GuestSortOption, direction: SortDirection) -> [GuestModel] {
        let isAscending = direction == .ascending
        return switch sortOption {
        case .name:
            sorted { isAscending ? $0.name < $1.name : $0.name > $1.name }
        case .country:
            sorted { isAscending ? $0.country < $1.country : $0.country > $1.country }
        case .count:
            sorted { isAscending ? $0.numberOfGuests < $1.numberOfGuests : $0.numberOfGuests > $1.numberOfGuests }
        }
    }
}

extension [GuestModel] {
    
}

