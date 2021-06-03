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
    let CreditSum: Int
    let ClientID: Int
    let CreditID: Int
}
