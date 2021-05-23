import RxSwift
import RxCocoa

final class RegisterViewModel: ViewModel {
    
    let nameSubject = BehaviorSubject<String?>(value: "")
    let binSubject = BehaviorSubject<String?>(value: "")
    let citySubject = BehaviorSubject<String?>(value: "")
    let streetSubject = BehaviorSubject<String?>(value: "")
    let houseNumberSubject = BehaviorSubject<String?>(value: "")
    let phoneSubject = BehaviorSubject<String?>(value: "")
    let emailSubject = BehaviorSubject<String?>(value: "")
    let selectCheckBox = BehaviorSubject<Void?>(value: ())
    let disposeBag = DisposeBag()
    
    var isValidForm: Observable<Bool> {
        return Observable.combineLatest(nameSubject, binSubject, citySubject, streetSubject, houseNumberSubject, phoneSubject, emailSubject) { name, bin, city, street, numberHouse, phone, email   in
            guard name != nil && bin != nil && city != nil && street != nil && email != nil else { return  false}
            
            return !(name!.isEmpty) && bin!.count > 10 && !city!.isEmpty && !street!.isEmpty && !numberHouse!.isEmpty  && phone!.count > 9 && email!.validEmail() //&& select ?? () == Void()

        }
    }
    
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
//        let loadCity: Observable<City>
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
    
//    private func loadJson() -> [City] {
//        if let url = Bundle.main.url(forResource: "city", withExtension: "json") {
//            do {
//                let data = try Data(contentsOf: url)
//                let decoder = JSONDecoder()
//                let city = try decoder.decode(CityList.self, from: data)
//                return city.cities
//            } catch let error {
//                print(error)
//                return []
//            }
//        }
//        return []
//    }
}
