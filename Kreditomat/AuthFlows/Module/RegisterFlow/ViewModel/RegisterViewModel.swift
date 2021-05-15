import RxSwift

final class RegisterViewModel: ViewModel {
    
    var name: String = ""
    var phone: String = ""
    var email: String = ""
    var city: String = ""
    var address: String = ""
    var house: String = ""
    var apartments: String = ""
    var bin: String = ""
    var lat: Double = 0.0
    var long: Double = 0.0
    
    struct Input {
        let registerTapped: Observable<Void>
    }
    
    struct Output {
        let token: Observable<LoadingSequence<ResponseStatus>>
    }
    
    private let authService: AuthenticationService
    
    init(authService: AuthenticationService) {
        self.authService = authService
    }
    
    func transform(input: Input) -> Output {
        let registerUser = input.registerTapped
            .flatMap { [unowned self] _ in
                authService.register(name: name, email: email, phone: phone, city: city, address: address, house: house, apartments: apartments, bin: bin, posLat: "", posLng: "")
            }.share()
        return .init(token: registerUser)
    }
}
