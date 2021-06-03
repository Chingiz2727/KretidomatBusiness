//
//  CreditTarget.swift
//  Kreditomat
//
//  Created by kairzhan on 5/19/21.
//

import Foundation

enum CreditTarget: ApiTarget {
    case getCredit(ClientID: Int, CreditID: Int, Signature: String)
    case clearCredit(ClientID: Int, CreditID: Int)
    
    var version: ApiVersion {
        .custom("")
    }
    
    var servicePath: String { "" }
    
    var path: String {
        switch self {
        case .getCredit:
            return "CheckOut"
        case .clearCredit:
            return "DoPayment"
        }
    }
    
    var method: HTTPMethod {
        return .post
    }
    
    var parameters: [String : Any]? {
        switch self {
        case let .clearCredit(ClientID, CreditID):
            return ["ClientID": ClientID, "CreditID": CreditID]
        case let .getCredit(ClientID, CreditID, Signature):
            return ["ClientID": ClientID, "CreditID": CreditID, "Signature": Signature]
        }
    }
    
    var stubData: Any { [:] }
}
