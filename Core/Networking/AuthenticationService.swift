import RxSwift
import RxRelay
import Foundation

public protocol AuthenticationService {
    var token: String? { get }
    var sessionStorage: UserSessionStorage { get }
    var authenticated: Observable<Bool> { get }
    func clearUserInfo()
    func checkUser(iin: String) -> Observable<LoadingSequence<CheckUserResponse>>
    func sendSms(phone: String) -> Observable<LoadingSequence<ResponseStatus>>
    func verification(phone: String, activateCode: String) -> Observable<LoadingSequence<ResponseStatus>>
    func signUp(iin: String, phone: String, ftoken: String, password: String, password2: String) -> Observable<LoadingSequence<UserAuthResponse>>
    func signIn(iin: String, password: String) -> Observable<LoadingSequence<UserAuthResponse>>
    func resetPassword(iin: String, phone: String, password: String, password2: String) -> Observable<LoadingSequence<ResponseStatus>>
    func updateToken(with newToken: UserResponse?)
    func forceLogout()
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
    
    public func checkUser(iin: String) -> Observable<LoadingSequence<CheckUserResponse>> {
        return apiService.makeRequest(to: AuthTarget.checkUser(iin: iin))
            .result()
            .asLoadingSequence()
    }
    
    public func sendSms(phone: String) -> Observable<LoadingSequence<ResponseStatus>> {
        return apiService.makeRequest(to: AuthTarget.sendSms(phone: phone))
            .result()
            .asLoadingSequence()
    }
    
    public func verification(phone: String, activateCode: String) -> Observable<LoadingSequence<ResponseStatus>> {
        return apiService.makeRequest(to: AuthTarget.verification(phone: phone, activateCode: activateCode))
            .result()
            .asLoadingSequence()
    }
    
    public func signUp(iin: String, phone: String, ftoken: String, password: String, password2: String) -> Observable<LoadingSequence<UserAuthResponse>> {
        return apiService.makeRequest(to: AuthTarget.signUp(iin: iin, phone: phone, ftoken: ftoken, password: password, password2: password2))
            .result(UserAuthResponse.self)
            .asLoadingSequence()
            .do(onNext: { [weak self] token in
                guard let token = token.result?.element?.user else { return }
                self?.updateToken(with: token)
                self?.token = token.access_token
            })
    }
    
    public func signIn(iin: String, password: String) -> Observable<LoadingSequence<UserAuthResponse>> {
        return apiService.makeRequest(to: AuthTarget.signIn(iin: iin, password: password))
            .result(UserAuthResponse.self)
            .asLoadingSequence()
            .do(onNext: { [weak self] token in
                guard let token = token.result?.element?.user else { return }
                self?.token = token.access_token
                self?.updateToken(with: token)
            })
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
}

public enum OAuthRefreshError: Error {
    case noRefreshToken
}
