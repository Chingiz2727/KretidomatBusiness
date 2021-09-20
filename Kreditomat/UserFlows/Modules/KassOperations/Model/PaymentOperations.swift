struct PaymentOperations: Codable {
    let success: Bool
    let message: String
    let errorCode: Int
    let data: DataClass

    enum CodingKeys: String, CodingKey {
        case success = "Success"
        case message = "Message"
        case errorCode = "ErrorCode"
        case data = "Data"
    }
}

// MARK: - DataClass
struct DataClass: Codable {
    let dateTo: String
    let totalMinus: Int
    let sellerBalanceOperations: [SellerBalanceOperation]
    let date: String
    let totalPlus, totalSum: Int
    let pagesCount: Int

    enum CodingKeys: String, CodingKey {
        case dateTo = "DateTo"
        case totalMinus = "TotalMinus"
        case sellerBalanceOperations = "SellerBalanceOperations"
        case date = "Date"
        case totalPlus = "TotalPlus"
        case totalSum = "TotalSum"
        case pagesCount = "PagesCount"
    }
}

// MARK: - SellerBalanceOperation
struct SellerBalanceOperation: Codable {
    let date: String
    let sum: Int
    let clientPhone, sellerName: String?
    let requestID: Int
    let sellerBalanceType: BalanceType
    let outgoingSum: Int?
    let operationType: String?
    let counterParty: String?
    let clientIIN: String?
    let incomeSum: Int?
    
    enum CodingKeys: String, CodingKey {
        case date = "Date"
        case sum = "Sum"
        case clientPhone = "ClientPhone"
        case sellerName = "SellerName"
        case sellerBalanceType = "SellerBalanceType"
        case requestID = "RequestID"
        case outgoingSum = "OutgoingSum"
        case operationType = "OperationType"
        case counterParty = "Counterparty"
        case clientIIN = "ClientIIN"
        case incomeSum = "IncomeSum"
    }
}

enum BalanceType: Int, Codable {
    case repayment = 1
    case giveKredit = 2
    case incassation = 3
    case replenishment = 4
    case addBonus = 5
    case getBonus = 6
    var title: String {
        switch self {
        case .repayment:
            return "Погашение микрокредита"
        case .giveKredit:
            return "Выдача микрокредита"
        case .incassation:
            return "Инкассация кассы"
        case .replenishment:
            return "Пополнение кассы"
        case .addBonus:
            return "Начисление бонусов"
        case .getBonus:
            return "Вывод бонусов"
        }
    }
}
