//
//  CalculatoViewState.swift
//  WeddingCalculator
//
//  Created by Bartosz Jurczyk on 02/09/2025.
//

import Foundation

@Observable
class CalculatorViewState {
    var isSaving: Bool = false
    var errorMessage: String? = nil
    var showAlert: Bool { errorMessage != nil }
}
