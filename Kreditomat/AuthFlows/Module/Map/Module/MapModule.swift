//
//  MapModule.swift
//  Kreditomat
//
//  Created by kairzhan on 5/20/21.
//

import Foundation
protocol MapModule: Presentable {
    typealias DidAddressSelectedHandler = ((Address) -> Void)
    var didAddressSelectedHandler: DidAddressSelectedHandler? { get set }
}
