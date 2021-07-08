//
//  CameraAction.swift
//  Kreditomat
//
//  Created by kairzhan on 5/11/21.
//

import Foundation

enum CameraAction {
    case giveCredit
    case payCredit
}

struct qrResult: Codable {
    let FIO: String
    let CreditSum: String
    let ClientID: String
    let CreditID: String
}

struct Checkout: Codable {
    let Success: Bool
    let Message: String
    let ErrorCode: Int
    let Data: CheckoutData
}

struct CheckoutData: Codable {
    let Balance: Int
    let BonusSum: Int
}
