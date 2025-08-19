import Foundation

enum CostNavigation: Hashable {
    case addCost
    case costDetail(Cost)
    case editCost(Cost)
    
    var id: String {
        switch self {
        case .addCost:
            return "addGuest"
        case .costDetail(let guest):
            return "guestDetail_\(guest.id)"
        case .editCost(let guest):
            return "editGuest_\(guest.id)"
        }
    }

    // Hashable conformance
    func hash(into hasher: inout Hasher) {
        switch self {
        case .addCost:
            hasher.combine("addCost")
        case .costDetail(_):
            hasher.combine("costDetail")
        case .editCost(_):
            hasher.combine("editCost")
        }
    }

    // Equatable conformance
    static func == (lhs: CostNavigation, rhs: CostNavigation) -> Bool {
        switch (lhs, rhs) {
        case (.addCost, .addCost):
            return true
        case (.costDetail(let lhs), .costDetail(let rhs)):
            return lhs.id == rhs.id
        case (.editCost(let lhs), .editCost(let rhs)):
            return lhs.id == rhs.id
        default:
            return false
        }
    }
}
