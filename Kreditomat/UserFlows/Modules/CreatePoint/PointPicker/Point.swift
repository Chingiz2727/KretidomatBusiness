//
//  Point.swift
//  Kreditomat
//
//  Created by kairzhan on 5/11/21.
//

import Foundation

struct PointResponse: Codable {
    let ErrorCode: Int
    let Message: String
    let Success: Bool
    let Data: [Point]
}

struct Point: Codable {
    let SellerID: Int
    let Phone: String
    let Name: String
    let City: String
    let Address: String
    let House: String
    let Apartments: String
    let BIN: String
    let CashierID: String
    let CashierName: String
    let CashierPhone: String
}
