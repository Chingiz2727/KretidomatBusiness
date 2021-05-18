import Swinject

public protocol AuthCoordinatorOutput {
    typealias AuthCompletion = (Bool) -> Void
    var authCompletion: AuthCompletion? { get set }
}

final class AuthCoordinator: BaseCoordinator, AuthCoordinatorOutput {
    
    var authCompletion: AuthCompletion?
    private let moduleFactory: AuthModuleFactory
    
    override init(router: Router, container: DependencyContainer) {
        self.moduleFactory = AuthModuleFactory(container: container)
        super.init(router: router, container: container)
    }
    
    override func start() {
        showAuth()
    }
    
    private func showAuth() {
        var module = moduleFactory.makeAuthState()
        
        module.signInTapped = { [weak self] in
            self?.showSignIn()
        }
        module.signUpTapped = { [weak self] in
            self?.showSignUp()
        }
        
        
        router.setRootModule(module)
    }
    
    private func showSignIn() {
        var module = moduleFactory.makeAuthUser()
        
        module.resetTapped = { [weak self] in
            self?.showResetPassword()
        }
        
        module.authTapped = { [weak self] in
            self?.authCompletion?(true)
        }
        router.push(module)
    }
    
    private func showSignUp() {
        var module = moduleFactory.makeRegister()
        
        module.offerTapped = { [weak self] in
            self?.showOfferView()
        }
        router.push(module)
    }
    
    private func showOfferView() {
        let module = moduleFactory.makeOfferShow()
        
//        router.present(module)
    }
    
    private func showResetPassword() {
        let module = moduleFactory.makeResetPassword()
        router.push(module)
    }
    
}
