import RxSwift
import RxRelay
import Foundation

public protocol AuthenticationService {
    var token: String? { get }
    var sessionStorage: UserSessionStorage { get }
    var authenticated: Observable<Bool> { get }
    func clearUserInfo()
   
    func resetPassword(iin: String, phone: String, password: String, password2: String) -> Observable<LoadingSequence<ResponseStatus>>
    func updateToken(with newToken: UserResponse?)
    func forceLogout()
    func authUser(phone: String, password: String) -> Observable<LoadingSequence<ResponseStatus>>
    func register(name: String, email: String, phone: String, city: String, address: String, house: String, apartments: String, bin: String, posLat: String, posLng: String) -> Observable<LoadingSequence<ResponseStatus>>
    
}

public protocol LogoutListener {
    func cleanUpAfterLogout()
}

public final class AuthenticationServiceImpl: AuthenticationService {
    
    
  
    public var token: String?
    
    public var authenticated: Observable<Bool> {
        return authenticatedRelay.asObservable().distinctUntilChanged()
    }
    
    private var authenticatedRelay = BehaviorRelay(value: false)
    
    private let apiService: ApiService
    private let configService: ConfigService
    private let authTokenService: AuthTokenService
    public var sessionStorage: UserSessionStorage
    private let infoStorage: UserInfoStorage
    private var logoutListeners = [LogoutListener]()
    
    init(
        apiService: ApiService,
        configService: ConfigService,
        authTokenService: AuthTokenService,
        sessionStorage: UserSessionStorage,
        infoStorage: UserInfoStorage
    ) {
        self.apiService = apiService
        self.configService = configService
        self.authTokenService = authTokenService
        self.sessionStorage = sessionStorage
        self.infoStorage = infoStorage
        token = sessionStorage.accessToken

        authenticatedRelay.accept(token != nil)
    }
    

    
   
    
    public func resetPassword(iin: String, phone: String, password: String, password2: String) -> Observable<LoadingSequence<ResponseStatus>> {
        return apiService.makeRequest(to: AuthTarget.resetPassword(iin: iin, phone: phone, password: password, password2: password2))
            .result()
            .asLoadingSequence()
    }

    public func addLogoutListener(_ logoutListener: LogoutListener) {
        logoutListeners.append(logoutListener)
    }
    
    public func forceLogout() {
        logoutListeners.forEach { $0.cleanUpAfterLogout() }
    }
    
    public func updateToken(with newToken: UserResponse?) {
        sessionStorage.save(accessToken: newToken?.access_token, refreshToken: nil)
        infoStorage.iin = newToken?.iin
        infoStorage.fullName = newToken?.fio
        infoStorage.mobilePhoneNumber = newToken?.phone
    }
    
    public func clearUserInfo() {
        infoStorage.clearAll()
        sessionStorage.clearAll()
    }
  
    public func authUser(phone: String, password: String) -> Observable<LoadingSequence<ResponseStatus>> {
        return apiService.makeRequest(to: AuthTarget.authUser(phone: phone, password: password))
            .result(ResponseStatus.self)
            .asLoadingSequence()
    }
    
    public func register(name: String, email: String, phone: String, city: String, address: String, house: String, apartments: String, bin: String, posLat: String, posLng: String) -> Observable<LoadingSequence<ResponseStatus>> {
        return apiService.makeRequest(to: AuthTarget.register(name: name, email: email, phone: phone, city: city, address: address, house: house, apartments: apartments, bin: bin, posLat: posLng, posLng: posLng))
            .result(ResponseStatus.self)
            .asLoadingSequence()
    }
}

public enum OAuthRefreshError: Error {
    case noRefreshToken
}
