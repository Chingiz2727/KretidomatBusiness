import Swinject
import RxSwift

final class AppCoordinator: BaseCoordinator {
    
    private let appCoordinatorFactory: AppCoordinatorFactory
    private let authService: AuthenticationService
    private let disposeBag = DisposeBag()
    
    override init(router: Router, container: DependencyContainer) {
        appCoordinatorFactory = AppCoordinatorFactory(container: container, router: router)
        let authService = container.resolve(AuthenticationService.self)!
        self.authService = authService
        super.init(router: router, container: container)
    }
    
    override func start() {
    }
 
    private func startAuth() {}
    private func startHome() {
    }
}

