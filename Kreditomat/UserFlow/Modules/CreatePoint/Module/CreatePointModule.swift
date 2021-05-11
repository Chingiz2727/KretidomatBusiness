//
//  CreatePointModule.swift
//  Kreditomat
//
//  Created by kairzhan on 5/10/21.
//

import Foundation
protocol CreatePointModule: Presentable {
    typealias Create = () -> Void
    var create: Create? { get set }
}
