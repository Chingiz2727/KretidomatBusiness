import Swinject
import AVFoundation
typealias DependencyContainer = Resolver

public final class DependencyContainerAssembly: Assembly {
    public func assemble(container: Container) {

        ApiServiceAssemblyImpl()
            .registerNetworkLayer(in: container)
        AuthServiceAssemblyImpl()
            .registerAuthService(in: container)
        container.register(ConfigService.self) { _ in
            ConfigServiceImpl()
        }.inObjectScope(.container)
        container.register(UIApplication.self) { _ in
            UIApplication.shared
        }.inObjectScope(.container)
        container.register(NotificationCenter.self) { _ in
            NotificationCenter.default
        }.inObjectScope(.container)
        
        container.register(UserInfoStorage.self) { _ in
            UserInfoStorage()
        }.inObjectScope(.container)
        container.register(UserSessionStorage.self) { _ in
            UserSessionStorage()
        }.inObjectScope(.container)
        container.register(AuthStateObserver.self) { _ in
            AuthStateObserver(userSession: container.resolve(UserInfoStorage.self)!, appSession: container.resolve(UserSessionStorage.self)!)
        }.inObjectScope(.container)
        // CameraUsage DI
        container.register(AVAuthorizationStatus.self) { _ in
            AVCaptureDevice.authorizationStatus(for: .video)
        }
        container.register(NotificationCenter.self) { _ in
            NotificationCenter.default
        }.inObjectScope(.container)
        container.register(KassOperationReportModule.self) { _ in
            KassOperationReportViewController()
        }
        container.register(MenuModule.self) { _ in
            let apiService = container.resolve(ApiService.self)!
            let viewModel = MainMenuViewModel(apiService: apiService)
            return MenuViewController(viewModel: viewModel, info: .init(AppSignature: "0", SellerID: 0, AlterNames: "", RegTime: "nil", RegCode: 0, Name: "nil", Email: "nil", Phone: "nil", City: "nil", Address: "nil", House: "nil", Apartments: "nil", UniqueCode: 0, BIN: "nil", Pos_Lat: "nil", Pos_Lng: "nil", Balance: 0, BonusSum: 0, CashierID: 0, CashierName: "nil", CashierPhone: "nil"))
        }
        
        container.register(AVMediaType.self) { _ in
            AVMediaType.video
        }
        

        container.register(AVCaptureDevice.self) { _ in
            let mediaType = container.resolve(AVMediaType.self)!
            return AVCaptureDevice.default(for: mediaType)!
        }

        container.register(AVCaptureSession.self) { _ in
            return AVCaptureSession()
        }
        
        container.register(AVCaptureVideoPreviewLayer.self) {  _ in
            let session = container.resolve(AVCaptureSession.self)!
            let layer = AVCaptureVideoPreviewLayer(session: session)
            return layer
        }
        
        container.register(CameraUsagePermission.self) {  _ in
            let status = container.resolve(AVAuthorizationStatus.self)!
            return CameraUsagePermission(avAuthorizationStatus: status)
        }
        
        container.register(CameraModule.self) { _ in
            let session = container.resolve(AVCaptureSession.self)!
            let device = container.resolve(AVCaptureDevice.self)!
            let layer = container.resolve(AVCaptureVideoPreviewLayer.self)!
            let cameraUsagePermission = container.resolve(CameraUsagePermission.self)!
            let controller = CameraViewController(
                avCaptureSession: session,
                avCaptureDevice: device,
                avCapturePreviewLayer: layer,
                cameraUsagePermession: cameraUsagePermission)
            return controller
    }
        container.register(SignatureModule.self) { _ in
            return SignatureViewController()
        }
        container.register(KassOperationFilterModule.self) { _ in
            return KassOperationFilterViewController()
        }
}
}
