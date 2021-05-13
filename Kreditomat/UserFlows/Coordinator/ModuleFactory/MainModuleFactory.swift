//
//  MainModuleFactory.swift
//  Kreditomat
//
//  Created by kairzhan on 5/11/21.
//

import Swinject

final class MainModuleFactory {
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
    
    func makeAboutKassa() -> AboutKassaModule {
        return AboutKassaViewController()
    }
}
