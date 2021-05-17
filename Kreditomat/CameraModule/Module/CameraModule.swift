//
//  CameraModule.swift
//  Kreditomat
//
//  Created by kairzhan on 5/11/21.
//

protocol CameraModule: Presentable {
    var cameraActionType: CameraAction? { get set }
    typealias GiveCredit = (String) -> Void
    var giveCredit: GiveCredit? { get set }
    typealias PayCredit = (String) -> Void
    var payCredit: PayCredit? { get set }
}
