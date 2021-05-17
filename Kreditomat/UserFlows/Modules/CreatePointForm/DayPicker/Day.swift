//
//  Day.swift
//  Kreditomat
//
//  Created by kairzhan on 5/13/21.
//

import Foundation

struct Day: Codable {
    let id: Int
    let shortName: String
    let longName: String
}

struct DayList: Codable {
    let days: [Day]
}
