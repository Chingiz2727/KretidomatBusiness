import UIKit

enum RegularTextFieldState {
    case error
    case success
    case selected
    case normal
    case disabled
    
    var backgroundColor: UIColor {
        switch self {
        case .error:
            return .error
        case .disabled:
            return UIColor.background.withAlphaComponent(0.4)
        default:
            return .white
        }
    }
    
    var borderColor: CGColor {
        switch self {
        case .error:
            return UIColor.error.cgColor
        case .success:
            return UIColor.secondary.cgColor
        default:
            return UIColor.primary.cgColor
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .disabled:
            return .lightGray
        default:
            return .black
        }
    }
    
    var textFont: UIFont {
        return .systemFont(ofSize: 13)
    }
}
