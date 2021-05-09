 import RxSwift

 final class AuthUserViewModel: ViewModel {
     
     struct Input {
         let userPhone: Observable<String?>
         let userPassword: Observable<String?>
         let authTapped: Observable<Void>
     }
     
     struct Output {
         let isLogged: Observable<LoadingSequence<ResponseStatus>>
     }
     
     private let authService: AuthenticationService
     
     init(authService: AuthenticationService) {
         self.authService = authService
     }
     
     func transform(input: Input) -> Output {
         let loginTap = input.authTapped
             .withLatestFrom(Observable.combineLatest(input.userPhone, input.userPassword))
             .flatMap { [unowned self] phone, password in
                 return authService.authUser(phone: phone ?? "", password: password ?? "")
             }.share()
         
         return .init(isLogged: loginTap)
     }
 }
