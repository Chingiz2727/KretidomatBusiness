//
//  CreateCashierFormModule.swift
//  Kreditomat
//
//  Created by kairzhan on 5/24/21.
//

import Foundation
protocol CreateCashierFormModule: Presentable {
    typealias PopModule = () -> Void
    var popModule: PopModule? { get set }
}
