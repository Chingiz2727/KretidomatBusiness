//
//  HomeModuleFactory.swift
//  Kreditomat
//
//  Created by kairzhan on 5/9/21.
//

import Swinject

final class HomeModuleFactory {
    private let container: DependencyContainer

    init(container: DependencyContainer) {
        self.container = container
    }
    
    func makeCabiner() -> CabinetModule {
        return CabinetViewController()
    }
    
    func makeCreatePoint() -> CreatePointModule {
        return CreatePointViewController()
    }
    
    func makeAttachCashier() -> AttachCashierModule {
        return AttachCashierViewController()
    }
}
