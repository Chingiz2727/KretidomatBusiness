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
        return RegisterViewController()
    }
    
    func makeResetPassword() -> ResetPasswordModule {
        return ResetPasswordViewController()
    }
 
}
