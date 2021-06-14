//
//  MainCoordinator.swift
//  Kreditomat
//
//  Created by Чингиз Куандык on 11.05.2021.
//

import Foundation

final class MainCoordinator: BaseCoordinator {
    private let moduleFactory: MainModuleFactory
    
    override init(router: Router, container: DependencyContainer) {
        moduleFactory = MainModuleFactory(container: container)
        super.init(router: router, container: container)
    }
    
    override func start() {
        startHome()
    }
    
    private func startHome() {
        var module = assembler.resolver.resolve(MenuModule.self)!
        module.selectMenu = { [weak self] menu, data in
            switch menu {
            case .mainPage:
                self?.showCabinet(data: data)
            case .createPoint:
                self?.showCreatePoint()
            case .createCashier:
                self?.showCreateCashier()
            case .getCredit:
                self?.showCamera(type: .giveCredit)
            case .clearCredit:
                self?.showCamera(type: .payCredit)
            case .aboutKassa:
                self?.showAboutKassa()
            case .changePassWord:
                self?.showChangePassword()
            case .logout:
                let authState = assembler.resolver.resolve(AuthStateObserver.self)!
                authState.forceLogout()
            default:
                return
            }
        }
        router.setRootModule(module)
    }
    
    private func showCreateCashierForm() {
        let module = moduleFactory.makeCreateCashierForm()
        router.push(module)
    }
    
    private func showCabinet(data: CabinetData) {
        let module = moduleFactory.makeCabiner(data: data)
        router.push(module)
    }
    
    private func showCreatePoint() {
        var module = moduleFactory.makeCreatePoint()
        module.create = { [weak self] in
            self?.showCreatePointForm()
        }
        router.push(module)
    }
    
    private func showCamera(type: CameraAction) {
        var module = container.resolve(CameraModule.self)!
        module.cameraActionType = type
        switch module.cameraActionType {
        case .giveCredit:
            module.giveCredit = { [weak self] qr in
                self?.showSignature(data: qr)
            }
        case .payCredit:
            module.showSucces = { [weak self] qr in
                self?.showSuccess(data: qr)
            }
            module.errorTapped = { [weak self] in
                self?.router.popToRootModule()
            }
        default:
            return
        }
        router.push(module)
    }
    
    private func showSuccess(data: qrResult) {
        var module = moduleFactory.makeSuccess(data: data)
        module.closeTapped = { [weak self] in
            self?.router.popToRootModule()
        }
        router.push(module)
    }
    
    private func showCreateCashier() {
        var module = moduleFactory.makeCreateCashier()
        module.create = { [weak self] in
            self?.showCreateCashierForm()
        }
        router.push(module)
    }
    
    private func showCreatePointForm() {
        let module = moduleFactory.makeCreatePointForm()
        router.push(module)
    }
    
    private func showAttachCashier() {
        let module = moduleFactory.makeAttachCashier()
        router.push(module)
    }
    
    private func showSignature(data: qrResult) {
        var module = moduleFactory.makeSignature(data: data)
        module.showSucces = { [weak self] data in
            self?.showSuccess(data: data)
        }
        module.errorTapped = { [weak self] in
            self?.router.popToRootModule()
        }
        router.push(module)
    }
    
    private func showAboutKassa() {
        let module = moduleFactory.makeAboutKassa()
        router.push(module)
    }
    
    private func showChangePassword() {
        var  module = moduleFactory.makeChangePassword()
        module.resetPasTapped = { [weak self] in
            self?.showResetPassword()
        }
        router.push(module)
    }
    
    private func showResetPassword() {
        let module = moduleFactory.makeResetPassword()
        router.push(module)
    }
}
