import UIKit
import RxSwift

final class ChangePasswordViewController: ViewController, ViewHolder, ChangePasswordModule {
    var changePasTapped: ChangePassTapped?
    var resetPasTapped: ResetPassTapped?
    
    typealias RootViewType = ChangePasswordView
    
    private let viewModel: ChangePasswordViewModel
    private let disposeBag = DisposeBag()
    
    init(viewModel: ChangePasswordViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = ChangePasswordView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        bindValidation()
        title = "Изменить пароль"
        navigationController?.navigationBar.layer.addShadow()
    }
    
    private func bindViewModel() {
        let output = viewModel.transform(
            input: .init(oldPassword: rootView.oldPassword.rx.text.asObservable(),
                         newPassword: rootView.newPassword.rx.text.asObservable(),
                         changeTapped: rootView.changePasswordButton.rx.tap.asObservable()))
        
        let result = output.changeTapped.publish()
        
        result.element
            .subscribe(onNext: { [unowned self] result in
                if result.Success == true {
                    self.presentCustomAlert(type: .changePass, ondismiss:  {
                        self.navigationController?.popViewController(animated: true)
                    })
                }
            })
            .disposed(by: disposeBag)
        
        result.errors
            .bind(to: rx.error)
            .disposed(by: disposeBag)
        
        result.connect()
            .disposed(by: disposeBag)
    }
    
    private func bindValidation() {
        rootView.changePasswordButton.isEnabled = false
        let newPassword = rootView.newPassword.rx.text.map { $0?.count ?? 0 > 5 }
        let repeatNewPassword = rootView.repeatNewPassword.rx.text.map { $0?.count ?? 0 > 5 }
        
        Observable.combineLatest([ newPassword, repeatNewPassword])
            .map { $0.allSatisfy { $0 }}
            .distinctUntilChanged()
            .bind(to: rootView.changePasswordButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }
    
    override func customBackButtonDidTap() {
        navigationController?.popViewController(animated: true)
    }
}
