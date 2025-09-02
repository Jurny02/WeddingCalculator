//
//  DateProvider.swift
//  WeddingCalculator
//
//  Created by Bartosz Jurczyk on 02/09/2025.
//

import Foundation

protocol DateProvider {
    func now() -> Date
}

class SystemDateProvider: DateProvider {
    func now() -> Date {
        Date()
    }
}

#if DEBUG
class MockDateProvider: DateProvider {
    var date: Date

    init(date: Date) {
        self.date = date
    }

    func now() -> Date {
        date
    }
}
#endif
