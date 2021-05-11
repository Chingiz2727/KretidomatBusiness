//
//  CabinetModule.swift
//  Kreditomat
//
//  Created by kairzhan on 5/9/21.
//

import Foundation
protocol CabinetModule: Presentable {
    typealias Create = () -> Void
    typealias Camera = () -> Void
    var create: Create? { get set }
    var camera: Camera? { get set }
}
