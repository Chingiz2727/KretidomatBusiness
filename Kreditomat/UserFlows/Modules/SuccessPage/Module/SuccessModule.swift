//
//  SuccessModule.swift
//  Kreditomat
//
//  Created by kairzhan on 5/10/21.
//

import Foundation
protocol SuccessModule: Presentable {
    typealias CloseTapped = () -> Void
    var closeTapped: CloseTapped? { get set }
}
