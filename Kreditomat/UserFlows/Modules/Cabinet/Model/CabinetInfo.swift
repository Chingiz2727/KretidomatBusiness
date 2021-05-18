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

struct CabinetData: Codable {
    let Name: String
    let Email: String
    let Phone: String
    let City: String
    let Address: String
    let House: String
    let Apartments: String
    let UniqueCode: String
    let BIN: String
    let Pos_Lat: String
    let Pos_Lng: String
    let Balance: Int
    let BonusSum: Int
    let CashierID: String
    let CashierName: String
    let CashierPhone: String
}
