//
//  CameraModule.swift
//  Kreditomat
//
//  Created by kairzhan on 5/11/21.
//

protocol CameraModule: Presentable {
    var cameraActionType: CameraAction? { get set }
    typealias GiveCredit = (qrResult) -> Void
    var giveCredit: GiveCredit? { get set }
    typealias PayCredit = (qrResult) -> Void
    var payCredit: PayCredit? { get set }
    typealias ShowSuccess = (qrResult) -> Void
    var showSucces: ShowSuccess? { get set }
}
