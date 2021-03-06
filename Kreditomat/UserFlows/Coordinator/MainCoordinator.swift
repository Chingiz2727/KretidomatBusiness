//
//  MainCoordinator.swift
//  Kreditomat
//
//  Created by Чингиз Куандык on 11.05.2021.
//

import Foundation
import UIKit

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
            case  .aboutBonus:
                self?.showOperations(type: .BonusHistory)
            case .aboutCredit:
                self?.showOperations(type: .PaymentHistory)
            case .share:
                ProgressView.instance.show()
                self?.shareLink()
            case .logout:
                let authState = assembler.resolver.resolve(AuthStateObserver.self)!
                authState.forceLogout()
            }
        }
        router.setRootModule(module)
    }
    
    private func showCreateCashierForm() {
        var module = moduleFactory.makeCreateCashierForm()
        module.popModule = { [weak self] in
            self?.router.popModule()
        }
        router.push(module)
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
                self?.showSignature(data: qr)
            }
        case .payCredit:
            module.showSucces = { [weak self] qr, checkoutData in
                self?.showSuccess(data: qr, titleText: "Вы успешно приняли денежные средства:", checkoutData: checkoutData)
            }
            module.errorTapped = { [weak self] in
                self?.router.popToRootModule()
            }
        default:
            return
        }
        router.push(module)
    }
    
    private func showOperations(type: OperationType) {
        var module = assembler.resolver.resolve(KassOperationReportModule.self, argument: type)!
        module.filterTapped = { [weak self] in
            self?.kassoperationFilter(operation: { filter in
                module.onfilterSelect?(filter)
            })
        }
        router.push(module)
    }
    
    private func showSuccess(data: qrResult, titleText: String, checkoutData: CheckoutData) {
        var module = moduleFactory.makeSuccess(data: data, titleText: titleText, checkoutData: checkoutData)
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
        module.showSucces = { [weak self] data, checkoutData in
            self?.showSuccess(data: data, titleText: "Вы успешно выдали денежные средства:", checkoutData: checkoutData)
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
    
    private func kassoperationFilter(operation:(((KassFilter))->Void)?) {
        var module = assembler.resolver.resolve(KassOperationFilterModule.self)!
        module.onFilterSended = { [weak self] filter in
            operation?(filter)
            self?.router.popModule()
        }
        router.push(module)
    }
    
    private func shareLink() {
        let url = URL(string: "http://itunes.apple.com/lookup?bundleId=1568426328")!
        ProgressView.instance.hide()
        let shareText = "Kreditomat Business - подключайся и зарабтывай вместе с нами деньги "
        let shareActivityController = UIActivityViewController(activityItems: [url, shareText], applicationActivities: nil)
        DispatchQueue.main.async {
            self.router.present(shareActivityController)
        }
    }
    
    
}
