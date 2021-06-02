import UIKit
import RxSwift

final class RegisterViewController: ViewController, ViewHolder, RegisterModule {
    var putAddress: PutAddress?
    
    var mapTapped: MapTapped?
    
    typealias RootViewType = RegisterView
    
    var offerTapped: OfferButtonTapped?
    var registerTapped: RegisterTapped?
    
    
    private let viewModel: RegisterViewModel
    private let disposeBag = DisposeBag()
    
    private var cityPickerDelegate: CityPickerViewDelegate
    private var cityPickerDataSource: CityPickerViewDataSource
    private let cityPicker = UIPickerView()
    private let mapController = MapViewController()
    
    init(viewModel: RegisterViewModel) {
        self.viewModel = viewModel
        self.cityPickerDataSource = CityPickerViewDataSource()
        self.cityPickerDelegate = CityPickerViewDelegate()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    override func loadView() {
        view = RegisterView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setupCityPickerView()
        title = "Регистрация"
        
    }
    
    private func bindViewModel() {
        let output = viewModel.transform(input: .init(registerTapped: rootView.registerButton.rx.tap.asObservable()))
        
        rootView.ipButton.rx.tap
            .subscribe(onNext: { [unowned self] in
                rootView.buttonActive(ipButtonSelected: true)
            })
            .disposed(by: disposeBag)
        
        rootView.tooButton.rx.tap
            .subscribe(onNext: { [unowned self] in
                rootView.buttonActive(ipButtonSelected: false)
            })
            .disposed(by: disposeBag)
        
        rootView.nameUserView.textField.rx.text.unwrap()
            .subscribe(onNext: { [unowned self] text in
                self.viewModel.name = text
            })
            .disposed(by: disposeBag)
        
        rootView.binUserView.textField.rx.text.unwrap()
            .subscribe(onNext: { [unowned self] text in
                self.viewModel.bin = text
            })
            .disposed(by: disposeBag)
        
        rootView.offerView.offerButton.rx.tap
            .subscribe(onNext: { [unowned self] in
                self.offerTapped?()
            })
            .disposed(by: disposeBag)
        
        rootView.offerView.checkBox.rx.tap
            .subscribe(onNext: { [unowned self]  in
                self.rootView.checkBox()
            })
            .disposed(by: disposeBag)
        
        cityPickerDelegate.selectedCity
            .subscribe(onNext: { [unowned self] city in
                rootView.cityView.cityListTextField.textField.text = city.name
            })
            .disposed(by: disposeBag)
        
        rootView.cityView.cityListTextField.textField.rx.text.unwrap()
            .subscribe(onNext: { [unowned self] text in
                self.viewModel.city = text
            })
            .disposed(by: disposeBag)
        
        
        rootView.streetView.textField.rx.text.unwrap()
            .subscribe(onNext: { [unowned self] text in
                self.viewModel.address = text
            })
            .disposed(by: disposeBag)
        
        rootView.numberHouse.rx.text.unwrap()
            .subscribe(onNext: { [unowned self] text in
                self.viewModel.house = text
            })
            .disposed(by: disposeBag)
        
        rootView.numberOffice.rx.text.unwrap()
            .subscribe(onNext: { [unowned self] text in
                self.viewModel.apartments = text
            })
            .disposed(by: disposeBag)
        
        rootView.numberPhoneTextField.rx.text.unwrap()
            .subscribe(onNext: { [unowned self] text in
                self.viewModel.phone = text
            })
            .disposed(by: disposeBag)
        
        rootView.emailTextField.rx.text.unwrap()
            .subscribe(onNext: { [unowned self] text in
                self.viewModel.email = text
            })
            .disposed(by: disposeBag)
        
        
        let token = output.token.publish()
        token.loading.bind(to: ProgressView.instance.rx.loading)
            .disposed(by: disposeBag)
        
        token.element.subscribe(onNext: { [unowned self] status in
            if status.Success == false {
                self.showErrorInAlert(text: status.Message)
            }  else {
                self.presentCustomAlert(type: .anketoOnRequest)
            }
        })
        .disposed(by: disposeBag)
        
        token.errors
            .bind(to: rx.error)
            .disposed(by: disposeBag)
        
        token.connect()
            .disposed(by: disposeBag)
        cityPickerDelegate.selectedCity.subscribe(onNext: { [unowned self] city in
            self.rootView.cityView.cityListTextField.textField.text = city.name
        })
        .disposed(by: disposeBag)
        
        rootView.coordinateButton.rx.tap
            .subscribe(onNext: { [unowned self] in
                self.mapTapped?()
            }).disposed(by: disposeBag)
        
        putAddress = { [unowned self] address in
            self.rootView.coordinateTextField.text = address.name
        }
        
        isNextButtonEnabled(name: rootView.nameUserView.textField.rx.text.orEmpty.asObservable(),
                            bin: rootView.binUserView.textField.rx.text.orEmpty.asObservable(),
                            city: rootView.cityView.cityListTextField.textField.rx.text.orEmpty.asObservable(),
                            street: rootView.streetView.textField.rx.text.orEmpty.asObservable(),
                            phone: rootView.numberPhoneTextField.rx.text.orEmpty.asObservable(),
                            email: rootView.emailTextField.rx.text.orEmpty.asObservable(),
                            coordinate: rootView.coordinateTextField.rx.text.orEmpty.asObservable(),
                            checkBox: rootView.offerView.checkBox.rx.tap.asObservable())
            .bind(to: rootView.registerButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }
    
    func isNextButtonEnabled(name: Observable<String>, bin: Observable<String>, city: Observable<String>, street: Observable<String>, phone: Observable<String>, email: Observable<String>, coordinate: Observable<String>, checkBox: Observable<Void>) -> Observable<Bool> {
        return Observable.combineLatest(
            [
                name.map { $0.count >= 5 },
                bin.map { $0.count >= 9},
                city.map { !$0.isEmpty},
                street.map { !$0.isEmpty},
                phone.map { $0.count >= 9},
                email.map { $0.validEmail() },
                coordinate.map { !$0.isEmpty },
                checkBox.scan(false) { state, _ in !state }.startWith(false)
            ]
        )
        .map { $0.allSatisfy { $0 } }
    }
    
    private func setupCityPickerView() {
        cityPicker.delegate = cityPickerDelegate
        cityPicker.dataSource = cityPickerDataSource
        rootView.cityView.cityListTextField.textField.inputView = cityPicker
    }
    
    override func customBackButtonDidTap() {
        navigationController?.popViewController(animated: true)
    }
    
}
