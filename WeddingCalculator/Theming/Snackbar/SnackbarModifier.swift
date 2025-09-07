//
//  SnackBarModifier.swift
//  WeddingCalculator
//
//  Created by Bartosz Jurczyk on 03/09/2025.
//

import SwiftUI

struct SnackbarModifier: ViewModifier {
    @Environment(SnackbarManager.self) var manager

    func body(content: Content) -> some View {
        ZStack {
            content

            VStack {
                if let config = manager.current {
                    SnackbarView( style: config)
                        .padding(.bottom)
                        .transition(.move(edge: .top).combined(with: .opacity))
                        .animation(.easeInOut, value: manager.current)
                }
                Spacer()
            }
            .onChange(of: manager.current) {
                manager.handleCurrent()
            }
            .onChange(of: manager.queue) {
                manager.handleQueue()
            }
        }
        .environment(manager)
    }
}

extension View {
    func snackbar() -> some View {
        self.modifier(SnackbarModifier())
    }
}
