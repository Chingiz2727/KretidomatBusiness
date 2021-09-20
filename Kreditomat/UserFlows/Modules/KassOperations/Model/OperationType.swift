enum OperationType: String {
    case PaymentHistory
    case BonusHistory
    
    var pdfType: Int {
        switch self {
        case .PaymentHistory:
            return 1
        default:
            return 2
        }
    }
}
