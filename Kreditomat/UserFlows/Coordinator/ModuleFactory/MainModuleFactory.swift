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
    
    func makeCabiner(data: CabinetData) -> CabinetModule {
        let apiService = container.resolve(ApiService.self)!
        let viewModel = CabinetViewModel(apiService: apiService)
        return CabinetViewController(viewModel: viewModel, data: data)
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
    
    func makeCreatePointForm() -> CreatePointFormModule {
        let viewModel = CreatePointFormViewModel()
        return CreatePointFormViewController(viewModel: viewModel)
    }
    
    func makeChangePassword() -> ChangePasswordModule {
        let apiService = container.resolve(ApiService.self)!
        let viewModel = ChangePasswordViewModel(apiService: apiService)
        return ChangePasswordViewController(viewModel: viewModel)
    }
    
    func makeResetPassword() -> ResetPasswordModule {
        return ResetPasswordViewController()
    }
    
    func makeSignature(data: qrResult) -> SignatureModule {
        let apiService = container.resolve(ApiService.self)!
        let viewModel = GiveCreditViewModel(apiService: apiService)
        return SignatureViewController(data: data, viewModel: viewModel)
    }
    
    func makeSuccess(data: qrResult) -> SuccessModule {
        return SuccessViewController(data: data)
    }
    
    func makeCreateCashier() -> CreateCashierModule {
        let apiService = container.resolve(ApiService.self)!
        let viewModel = CreateCashierViewModel(apiService: apiService)
        return CreateCashierViewController(viewModel: viewModel)
    }
    
    func makeCreateCashierForm() -> CreateCashierFormModule {
        let apiService = container.resolve(ApiService.self)!
        let viewModel = CreateCashierFormViewModel(apiService: apiService)
        return CreateCashierFormViewController(viewModel: viewModel)
    }
}
