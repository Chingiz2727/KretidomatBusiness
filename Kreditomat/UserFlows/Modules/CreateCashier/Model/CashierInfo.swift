//
//  Cashier.swift
//  Kreditomat
//
//  Created by kairzhan on 5/30/21.
//

import Alamofire

struct CashierInfo: Codable {
    public let ErrorCode: Int
    public let Message: String
    public let Success: Bool
    let Data: [CashierData]
}

struct CashierData: Codable {
    let SellerUserID: Int
    let Name: String
    let SellerID: Int
    let Phone: String
    let Email: String
}


