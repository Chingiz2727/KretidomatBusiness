import RxSwift

final class ResetPasswordViewModel: ViewModel {
    
    private let apiService: AuthenticationService
    
    init(apiService: AuthenticationService) {
        self.apiService = apiService
    }
    
    struct Input {
        let phoneText: Observable<String>
        let emailText: Observable<String>
        let resetTapped: Observable<Void>
    }
    
    struct Output {
        let resetTapped: Observable<LoadingSequence<ResponseStatus>>
    }
    
    func transform(input: Input) -> Output {
        
        let resetPassword = input.resetTapped
            .withLatestFrom(Observable.combineLatest(input.phoneText,
                                                     input.emailText))
            .flatMap { [unowned self] phone, email in
                return apiService.resetPassword(phone: phone, email: email)
            }
        
        return .init(resetTapped: resetPassword)
    }
    
}
