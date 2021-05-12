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
        module.selectMenu = { [weak self] menu in
            switch menu {
            case .aboutCredit:
                self?.showKassReport()
            default:
                break
            }
        }
        router.setRootModule(module)
    }
    
    private func showSignature() {
        let module = assembler.resolver.resolve(SignatureModule.self)!
        router.push(module)
    }
    
    private func showKassReport() {
        let module = assembler.resolver.resolve(KassOperationReportModule.self)!
        router.push(module)
    }
}
