//
//  EmptyStateView.swift
//  WeddingCalculator
//
//  Created by Bartosz Jurczyk on 19/08/2025.
//

import SwiftUI

struct EmptyStateView: View {
    let title: String
    let message: String?
    let systemImageName: String

    // Optional primary action
    var actionTitle: String?
    var action: (() -> Void)?

    init(title: String,
         message: String? = nil,
         systemImageName: String = "tray",
         actionTitle: String? = nil,
         action: (() -> Void)? = nil) {
        self.title = title
        self.message = message
        self.systemImageName = systemImageName
        self.actionTitle = actionTitle
        self.action = action
    }

    var body: some View {
        VStack(spacing: 16) {
            ContentUnavailableView {
                Label(title, systemImage: systemImageName)
            } description: {
                if let message {
                    Text(message)
                }
            }

            if let actionTitle, let action {
                Button(actionTitle) { action() }
                    .buttonStyle(.borderedProminent)
            }
        }
        .padding()
    }
}

#Preview {
    EmptyStateView(title: "No data",
                   message: "Add your first item to get started",
                   systemImageName: "tray",
                   actionTitle: "Add",
                   action: {})
}
