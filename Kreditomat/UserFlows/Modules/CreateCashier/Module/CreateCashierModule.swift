//
//  CreateCashierModule.swift
//  Kreditomat
//
//  Created by kairzhan on 5/24/21.
//

import Foundation
protocol CreateCashierModule: Presentable {
    typealias Create = () -> Void
    var create: Create? { get set }
}
