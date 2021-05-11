//
//  MainCoordinator.swift
//  Kreditomat
//
//  Created by Чингиз Куандык on 11.05.2021.
//

import Foundation

final class MainCoordinator: BaseCoordinator {
    override func start() {
        startHome()
    }
    
    private func startHome() {
        var module = assembler.resolver.resolve(MenuModule.self)!
        router.setRootModule(module)
    }
    
    private func showSignature() {
        let module = assembler.resolver.resolve(SignatureModule.self)!
        router.push(module)
    }
}
