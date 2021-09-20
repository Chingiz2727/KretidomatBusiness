//
//  CabinetInfo.swift
//  Kreditomat
//
//  Created by kairzhan on 5/18/21.
//

import Alamofire

public struct CabinetInfo: Codable {
    public let ErrorCode: Int
    public let Message: String
    public let Success: Bool
    let Data: CabinetData
}

public struct CabinetData: Codable {
    let AppSignature: String?
    let SellerID: Int
    let AlterNames: String
    let RegTime: String
    let RegCode: Int
    let Name: String
    let Photo: String?
    let Email: String?
    let Phone: String
    let City: String
    let Address: String
    let House: String
    let Apartments: String
    let UniqueCode: Int
    let BIN: String?
    let Pos_Lat: String?
    let Pos_Lng: String?
    let Balance: Int
    let BonusSum: Int
    let CashierID: Int
    let CashierName: String
    let CashierPhone: String
    let Role: Role
}

enum Role: String, Codable {
    case agent = "Agent"
    case cashier = "Cashier"
}
