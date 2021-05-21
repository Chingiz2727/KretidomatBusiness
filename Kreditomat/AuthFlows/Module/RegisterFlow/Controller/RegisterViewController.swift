import UIKit
import RxSwift

final class RegisterViewController: ViewController, ViewHolder, RegisterModule {    
    typealias RootViewType = RegisterView

    var offerTapped: OfferButtonTapped?
    var registerTapped: RegisterTapped?
    
    var isValidEmail : Observable<Bool> {
        return emailSubject.map { $0!.validEmail()}
    }
//    var isValidPhone: Observable<Bool> {
//        return phoneSubject.map { $0.}
//    }
//    var isValidBin: Observable<Bool>{
//        binSubject.map { $0.val}
//    }

    private let viewModel: RegisterViewModel
    private let disposeBag = DisposeBag()
    
    private var cityPickerDelegate: CityPickerViewDelegate
    private var cityPickerDataSource: CityPickerViewDataSource
    private let cityPicker = UIPickerView()
    private let emailSubject = BehaviorSubject<String?>(value: "")
    private let phoneSubject = BehaviorSubject<String?>(value: "")
    private let binSubject = BehaviorSubject<String?>(value: "")
    
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
        bindViewValidation()
        setupCityPickerView()
        title = "Регистрация"
        navigationController?.navigationBar.layer.addShadow()
        
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
    }
    
    private func bindViewValidation() {
        rootView.nameUserView.textField.rx.text
            .bind(to: viewModel.nameSubject)
            .disposed(by: disposeBag)
        
        rootView.binUserView.textField.rx.text
            .bind(to: viewModel.binSubject)
            .disposed(by: disposeBag)
        
        rootView.cityView.cityListTextField.textField.rx.text
            .bind(to: viewModel.citySubject)
            .disposed(by: disposeBag)
        
        rootView.streetView.textField.rx.text
            .bind(to: viewModel.streetSubject)
            .disposed(by: disposeBag)
        
        rootView.numberHouse.rx.text
            .bind(to: viewModel.houseNumberSubject)
            .disposed(by: disposeBag)
        
        rootView.numberPhoneTextField.rx.text
            .bind(to: viewModel.phoneSubject)
            .disposed(by: disposeBag)
        
        rootView.emailTextField.rx.text
            .bind(to: viewModel.emailSubject)
            .disposed(by: disposeBag)
        
//        rootView.offerView.checkBox.rx.tap
//            .bind(to: viewModel.selectCheckBox)
//            .disposed(by: disposeBag)
        
        
        viewModel.isValidForm
            .distinctUntilChanged()
            .bind(to: rootView.registerButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        
    }
    
    private func setupCityPickerView() {
        cityPicker.delegate = cityPickerDelegate
        cityPicker.dataSource = cityPickerDataSource
        rootView.cityView.cityListTextField.textField.inputView = cityPicker
    }
    
}
