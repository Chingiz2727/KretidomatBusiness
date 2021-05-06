import Swinject

protocol AuthCheckCoordinator: BaseCoordinator {}

extension AuthCheckCoordinator {
    
    func checkAuth(onAuth:(() -> Void)?) {
        let authCoordinator = AuthCoordinator(router: router, container: container)
        authCoordinator.authCompletion = { [weak self, weak authCoordinator] auth in
            if auth {
                self?.removeDependency(authCoordinator)
//                self.
            }
        }
        addDependency(authCoordinator)
        authCoordinator.start()
    }
    
}
