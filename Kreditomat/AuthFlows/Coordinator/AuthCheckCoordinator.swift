import Swinject

protocol AuthCheckCoordinator: BaseCoordinator {}

extension AuthCheckCoordinator {
    
    func checkAuth(onAuth:(() -> Void)?) {
        let userSession = assembler.resolver.resolve(UserSessionStorage.self)!
        guard userSession.accessToken == nil else {
            onAuth?()
            return
        }
        let authCoordinator = AuthCoordinator(router: router, container: container)
        authCoordinator.authCompletion = { [weak self, weak authCoordinator] auth in
            if auth {
                self?.removeDependency(authCoordinator)
                onAuth?()
            }
        }
        addDependency(authCoordinator)
        authCoordinator.start()
    }
    
}
