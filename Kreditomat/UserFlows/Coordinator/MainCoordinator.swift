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
        module.selectMenu = { [weak self] menu in
            switch menu {
            case .mainPage:
                self?.showCabinet()
            case .createPoint:
                self?.showCreatePoint()
            case .getCredit:
                self?.showCamera(type: .giveCredit)
            case .clearCredit:
                self?.showCamera(type: .payCredit)
            default:
                return
            }
        }
        router.setRootModule(module)
    }
    
    private func showCabinet() {
        let module = moduleFactory.makeCabiner()
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
                self?.showSignature()
            }
        case .payCredit:
            module.payCredit = { [weak self] qr in
            }
        default:
            return
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
    
    private func showSignature() {
        let module = assembler.resolver.resolve(SignatureModule.self)!
        router.push(module)
    }
}
