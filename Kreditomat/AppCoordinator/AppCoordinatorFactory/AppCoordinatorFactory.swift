import Swinject

final class AppCoordinatorFactory {
    private let container: DependencyContainer
    private let router: Router
    
    init(container: DependencyContainer, router: Router) {
        self.container = container
        self.router = router
    }
    
    func makeAuthCoordinator() -> Coordinator {
        return AuthCoordinator(router: router, container: container)
    }
    
    func tabBarCoordinator() -> Coordinator /*->Coordinator && HomeTabBarCoordinatorOutput*/ {
        return BaseCoordinator(router: router, container: container)
    }
    
    func msainCoordinator() -> Coordinator {
        return MainCoordinator(router: router, container: container)
    }
    
}
