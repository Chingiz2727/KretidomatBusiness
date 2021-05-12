import UIKit
import RxSwift

final class RegisterViewController: ViewController, ViewHolder, RegisterModule {
    typealias RootViewType = RegisterView

    var offerTapped: OfferButtonTapped?
    var registerTapped: RegisterTapped?

    private let viewModel: RegisterViewModel
    private let disposeBag = DisposeBag()
    
    init(viewModel: RegisterViewModel) {
        self.viewModel = viewModel
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
    }
    
    private func bindViewModel() {
//        let output = viewModel.transform(
//            input: .init(registerTapped: rootView.registerButton.rx.tap.asObservable(),
//                         nameUser: rootView.nameUserView.textField.rx.text.asObservable(),
//                         email: rootView.emailTextField.rx.text.asObservable(), phone: <#T##Observable<String>#>, city: <#T##Observable<String>#>, address: <#T##Observable<String>#>, house: <#T##Observable<String>#>, apartments: <#T##Observable<String>#>, bin: <#T##Observable<String>#>, posLat: <#T##Observable<String>#>, posLng: <#T##Observable<String>#>))
        
        rootView.offerView.offerButton.rx.tap
            .subscribe(onNext: { [unowned self] in
                self.offerTapped?()
            }).disposed(by: disposeBag)
    }
    
}
