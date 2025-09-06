//
//  SnackBarHandler.swift
//  WeddingCalculator
//
//  Created by Bartosz Jurczyk on 04/09/2025.
//

import SwiftUI
import Combine

@MainActor @Observable
class SnackbarManager {
    private(set) var current: SnackBarConfig?
    private(set) var queue: [SnackBarConfig] = []

    init() { }

    func show(_ config: SnackBarConfig) {
        guard queue.last != config, queue.count < 5 else { return }
        queue.append(config)
        print(queue)
    }

    func pop() {
        withAnimation(.linear(duration: 0.5)) {
            current = queue.removeFirst()
        }
    }

    func handleQueue() {
        if current == nil, queue.count == 1 {
            pop()
        }
    }

    func handleCurrent() {
        if current != nil {
            Task { @MainActor [weak self] in
                guard let self else { return }
                try? await Task.sleep(for: .seconds(2))
                withAnimation(.linear(duration: 0.5)) { current = nil }
            }
        }
        if current == nil, queue.first != nil {
            Task { @MainActor [weak self] in
                guard let self else { return }
                pop()
            }
        }
    }
}
