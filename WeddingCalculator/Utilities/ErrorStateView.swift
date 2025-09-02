//
//  ErrorStateView.swift
//  WeddingCalculator
//
//  Created by Bartosz Jurczyk on 19/08/2025.
//

import SwiftUI

struct ErrorStateView: View {
    let title: String
    let message: String?
    let systemImageName: String

    // Optional primary and secondary actions
    var retryTitle: String?
    var retryAction: (() -> Void)?
    var secondaryTitle: String?
    var secondaryAction: (() -> Void)?

    init(title: String,
         message: String? = nil,
         systemImageName: String = "exclamationmark.triangle",
         retryTitle: String? = nil,
         retryAction: (() -> Void)? = nil,
         secondaryTitle: String? = nil,
         secondaryAction: (() -> Void)? = nil) {
        self.title = title
        self.message = message
        self.systemImageName = systemImageName
        self.retryTitle = retryTitle
        self.retryAction = retryAction
        self.secondaryTitle = secondaryTitle
        self.secondaryAction = secondaryAction
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

            HStack(spacing: 12) {
                if let retryTitle, let retryAction {
                    Button(retryTitle) { retryAction() }
                        .buttonStyle(.borderedProminent)
                }
                if let secondaryTitle, let secondaryAction {
                    Button(secondaryTitle) { secondaryAction() }
                        .buttonStyle(.bordered)
                }
            }
        }
        .padding()
    }
}

#Preview {
    ErrorStateView(title: "Something went wrong",
                   message: "We couldn't fetch your data",
                   retryTitle: "Try again",
                   retryAction: {},
                   secondaryTitle: "Help",
                   secondaryAction: {})
}
