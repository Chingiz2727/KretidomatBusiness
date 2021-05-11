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
                self?.showCamera()
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
            self?.showAttachCashier()
        }
        router.push(module)
    }
    
    private func showCamera() {
        var module = container.resolve(CameraModule.self)!
        switch module.cameraActionType {
        case .giveCredit:
            showSignature()
        default:
            return
        }
        router.push(module)
    }
    
    private func showSignature() {
        
    }
    
    private func showAttachCashier() {
        let module = moduleFactory.makeAttachCashier()
        router.push(module)
    }
}
