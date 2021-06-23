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
        let apiService = container.resolve(ApiService.self)!
        let viewModel = CreatePointViewModel(apiService: apiService)
        return CreatePointViewController(viewModel: viewModel)
    }
    
    func makeAttachCashier() -> AttachCashierModule {
        return AttachCashierViewController()
    }
    
    func makeAboutKassa() -> AboutKassaModule {
        let apiService = container.resolve(ApiService.self)!
        let viewModel = AboutKassaViewModel(apiService: apiService)
        return AboutKassaViewController(viewModel: viewModel)
    }
    
    func makeCreatePointForm() -> CreatePointFormModule {
        let apiService = container.resolve(ApiService.self)!
        let viewModel = CreatePointFormViewModel(apiService: apiService)
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
    
    func makeSuccess(data: qrResult, titleText: String, checkoutData: CheckoutData) -> SuccessModule {
        return SuccessViewController(data: data, titleText: titleText, checkoutData: checkoutData)
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
