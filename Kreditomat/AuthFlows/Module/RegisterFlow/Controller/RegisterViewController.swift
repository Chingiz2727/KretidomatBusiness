import UIKit
import RxSwift

final class RegisterViewController: ViewController, ViewHolder, RegisterModule {    
    typealias RootViewType = RegisterView

    var offerTapped: OfferButtonTapped?
    var registerTapped: RegisterTapped?

    private let viewModel: RegisterViewModel
    private let disposeBag = DisposeBag()
    
    private var cityPickerDelegate: CityPickerViewDelegate
    private var cityPickerDataSource: CityPickerViewDataSource
    private let cityPicker = UIPickerView()
    
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
        bindView()
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
    
    private func bindView() {
        bindMaskTextField()
        let filled = [
            rootView.nameUserView.textField.filled,
            rootView.binUserView.textField.filled,
            rootView.cityView.cityListTextField.textField.filled,
            rootView.streetView.textField.filled,
            rootView.numberHouse.isFilled,
            rootView.numberOffice.isFilled,
            rootView.numberPhoneTextField.isFilled,
            rootView.emailTextField.filled
//            rootView.offerView.checkBox.isS
        ]
        Observable.combineLatest(filled.map {$0}) { $0.allSatisfy {$0}}
            .distinctUntilChanged()
            .bind(to: rootView.registerButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }
    
    private func bindMaskTextField() {
//        rootView.numberPhoneTextField.format = "[000] [000]-[00]-[00]"
    }
    
    private func setupCityPickerView() {
        cityPicker.delegate = cityPickerDelegate
        cityPicker.dataSource = cityPickerDataSource
        rootView.cityView.cityListTextField.textField.inputView = cityPicker
    }
    
}
