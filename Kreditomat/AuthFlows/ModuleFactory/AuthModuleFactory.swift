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
        
        return AuthUserViewController()
    }
    
    func makeRegister() -> RegisterModule {
        return RegisterViewController()
    }
 
}
