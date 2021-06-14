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
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getCashiers:
            return .get
        case .createCashier:
            return .put
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
        }
    }
    
    var stubData: Any { return [:] }
    
    
}
