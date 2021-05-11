//
//  HomeCoordinator.swift
//  Kreditomat
//
//  Created by kairzhan on 5/9/21.
//

import Swinject

final class HomeCoordinator: BaseCoordinator {
    private let moduleFactory: HomeModuleFactory
    
    override init(router: Router, container: DependencyContainer) {
        moduleFactory = HomeModuleFactory(container: container)
        super.init(router: router, container: container)
    }
    
    override func start() {
        showCabinet()
    }
    
    private func showCabinet() {
        var module = moduleFactory.makeCabiner()
        module.create = { [weak self] in
            self?.showCreatePoint()
        }
        module.camera = { [weak self] in
            self?.showCamera()
        }
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
        let module = container.resolve(CameraModule.self)!
        router.push(module)
    }
    
    private func showAttachCashier() {
        let module = moduleFactory.makeAttachCashier()
        router.push(module)
    }
}
