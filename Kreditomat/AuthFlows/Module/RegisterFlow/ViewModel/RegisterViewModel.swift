import RxSwift

final class RegisterViewModel: ViewModel {
    
    struct Input {
        let registerTapped: Observable<Void>
        let nameUser: Observable<String>
        let email: Observable<String>
        let phone: Observable<String>
        let city: Observable<String>
        let address: Observable<String>
        let house: Observable<String>
        let apartments: Observable<String>
        let bin: Observable<String>
        let posLat: Observable<String>
        let posLng: Observable<String>
    }
    
    struct Output {
        let token: Observable<LoadingSequence<ResponseStatus>>
    }
    
    private let authService: AuthenticationService
    
    init(authService: AuthenticationService) {
        self.authService = authService
    }
    
    func transform(input: Input) -> Output {
                    
        let firstStruct = Observable.combineLatest(input.nameUser,
                                                   input.email,
                                                   input.phone,
                                                   input.city,
                                                   input.address,
                                                   input.house,
                                                   input.apartments,
                                                   input.bin)
        
        let secondStruct = Observable.combineLatest(input.posLat,
                                                    input.posLng)
       
        let registerUser = input.registerTapped
            .withLatestFrom(Observable.combineLatest(input.nameUser,
                                                     input.email,
                                                     input.phone,
                                                     input.city,
                                                     input.address,
                                                     input.house,
                                                     input.apartments,
                                                     input.bin ))
            .flatMap { [unowned self] name, email, phone, city, address, house, apartments, bin  in
                authService.register(name: name, email: email, phone: phone, city: city, address: address, house: house, apartments: apartments, bin: bin, posLat: "", posLng: "")
            }.share()
            
        
        
        return .init(token: registerUser)
    }
}
