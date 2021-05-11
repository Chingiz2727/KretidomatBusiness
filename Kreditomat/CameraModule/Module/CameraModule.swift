//
//  CameraModule.swift
//  Kreditomat
//
//  Created by kairzhan on 5/11/21.
//

protocol CameraModule: Presentable {
    var cameraActionType: CameraAction? { get set }
}
