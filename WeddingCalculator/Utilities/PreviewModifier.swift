//
//  PreviewModifier.swift
//  WeddingCalculator
//
//  Created by Bartosz Jurczyk on 07/09/2025.
//

import SwiftUI

#if DEBUG

extension View {
    func appEnvironment() -> some View {
        self
            .modelContainer(for: [Cost.self, GuestModel.self])
            .environment(NavigationManager<CostNavigation>())
            .environment(SnackbarManager())
    }
}

#endif
