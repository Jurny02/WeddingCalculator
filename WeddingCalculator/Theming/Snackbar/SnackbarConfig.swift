import SwiftUI

enum SnackbarConfig: Equatable {
    case success(message: String), error(message: String), warning(message: String), info(message: String)

    var backgroundColor: Color {
        switch self {
        case .success: .green.opacity(0.9)
        case .error: .red.opacity(0.9)
        case .warning: .orange.opacity(0.9)
        case .info: .blue.opacity(0.9)
        }
    }

    var icon: Image {
        switch self {
        case .success: .init(systemName: "checkmark.circle.fill")
        case .error: .init(systemName: "xmark.octagon.fill")
        case .warning: .init(systemName: "exclamationmark.triangle.fill")
        case .info: .init(systemName: "info.circle.fill")
        }
    }

    var message: String {
        switch self {
        case .success(message: let msg): msg
        case .error(message: let msg): msg
        case .warning(message: let msg): msg
        case .info(message: let msg): msg
        }
    }
}
