import Swinject

final class AuthModuleFactory {
    private let container: DependencyContainer
    
    init(container: DependencyContainer) {
        self.container = container
    }
    
    func makeAuthState() -> AuthStateModule {
        return AuthStateViewController()
    }
    
    func makeAuthUser() -> AuthUserModule {
        let apiService = container.resolve(AuthenticationService.self)!
        let viewModel = AuthUserViewModel(authService: apiService)
        return AuthUserViewController(viewModel: viewModel)
    }
    
    func makeRegister() -> RegisterModule {
        let apiService = container.resolve(AuthenticationService.self)!
        let viewModel = RegisterViewModel(authService: apiService)
        return RegisterViewController(viewModel: viewModel)
    }
    
    func makeOfferShow() {
        
    }
    
    func makeResetPassword() -> ResetPasswordModule {
        return ResetPasswordViewController()
    }
 
    func makeMap() -> MapModule {
        return MapViewController()
    }
}
