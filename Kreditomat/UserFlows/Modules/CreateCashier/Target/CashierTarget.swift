//
//  CashierTarget.swift
//  Kreditomat
//
//  Created by kairzhan on 5/30/21.
//

import Foundation

enum CashierTarget: ApiTarget {
    case getCashiers
    case createCashier(name: String, email: String, phone: String)
    case attachCashier(sellerId: Int, sellerUserId: Int)
    case block(sellerId: Int, sellerUserId: Int, type: Int)
    
    var version: ApiVersion {
        .custom("")
    }
    
    var servicePath: String { "" }
    
    var path: String {
        switch self {
        case .getCashiers:
            return "GetCashiers"
        case .createCashier:
            return "RegisterCashier"
        case .attachCashier:
            return "AttachCashierToPoint"
        case .block:
            return "Disable"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getCashiers:
            return .get
        case .createCashier, .attachCashier:
            return .put
        case .block:
            return .post
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .getCashiers:
            return [:]
        case let  .createCashier(name, email, phone):
            return [
                "name": name,
                "email": email,
                "phone": phone
            ]
        case let .attachCashier(sellerId, sellerUserId):
            return ["sellerId": sellerId, "sellerUserId": sellerUserId]
        case let .block(sellerId, sellerUserId, type):
            return ["sellerId": sellerId, "sellerUserId": sellerUserId, "type": type]
        }
    }
    
    var stubData: Any { return [:] }
    
    
}
