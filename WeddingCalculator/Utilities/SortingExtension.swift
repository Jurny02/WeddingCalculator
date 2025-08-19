//
//  SortingExtension.swift
//  WeddingCalculator
//
//  Created by Bartosz Jurczyk on 19/08/2025.
//

import Foundation

extension Sequence {
    func sorted<T: Comparable>(
        by keyPath: KeyPath<Element, T>,
        direction: SortDirection
    ) -> [Element] {
        sorted { a, b in
            switch direction {
            case .ascending:
                a[keyPath: keyPath] < b[keyPath: keyPath]
            case .descending:
                a[keyPath: keyPath] > b[keyPath: keyPath]
            }
        }
    }
}
