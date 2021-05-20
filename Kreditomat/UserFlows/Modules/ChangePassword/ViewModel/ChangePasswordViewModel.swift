import RxSwift

final class ChangePasswordViewModel: ViewModel {
    
    private let apiService: ApiService
    
    init(apiService: ApiService) {
        self.apiService = apiService
    }
    
    struct Input {
        let oldPassword: Observable<String?>
        let newPassword: Observable<String?>
        let changeTapped: Observable<Void>
    }
    
    struct Output {
        let changeTapped: Observable<LoadingSequence<ResponseStatus>>
    }
    
    func transform(input: Input) -> Output {
        let changePassword = input.changeTapped
            .withLatestFrom(Observable.combineLatest(input.oldPassword, input.newPassword))
            .flatMap { [unowned self] old, new in
                return apiService.makeRequest(to: ChangePassTarget.changePassword(oldPass: old ?? "", newPass: new ?? ""))
                    .result(ResponseStatus.self)
            }.asLoadingSequence()
            .share()
        
        return .init(changeTapped: changePassword)
    }
}
