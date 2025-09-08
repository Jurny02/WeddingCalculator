//
//  NewGuestModel.swift
//  WeddingCalculator
//
//  Created by Bartosz Jurczyk on 08/09/2025.
//

import SwiftUI
import SwiftData

@Observable
final class NewGuestModel {
    enum NGMError: Error, SnackbarRepresentable {
        case validationFailed
        var snackbarConfig: SnackbarConfig {
            switch self {
            case .validationFailed:
                    .error(message: "Please fill all fields")
            }
        }
    }

    var name: String = ""
    var numberOfGuests: Int = 1
    var country: String = ""
    var confirmed: Bool = false

    var isInvalid: Bool {
        name.isEmpty || country.isEmpty
    }

    func addGuest(to context: ModelContext) throws(NGMError) {
        guard isInvalid == false else { throw .validationFailed }
        context.insert(GuestModel(self))
    }
}

extension GuestModel {
    convenience init(_ newGuestModel: NewGuestModel) {
        self.init(
            name: newGuestModel.name,
            confirmed: newGuestModel.confirmed,
            numberOfGuests: newGuestModel.numberOfGuests,
            country: newGuestModel.country
        )
    }
}
