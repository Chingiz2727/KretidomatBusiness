import UIKit
import RxSwift

final class AuthUserViewController: ViewController, ViewHolder, AuthUserModule {
    
    var authTapped: AuthButtonTap?
    var resetTapped: ResetButtonTap?
    
    typealias RootViewType = AuthUserView
    
    private let viewModel: AuthUserViewModel
    private let userSession = assembler.resolver.resolve(UserSessionStorage.self)!
    private let disposeBag = DisposeBag()
    
    init(viewModel: AuthUserViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = AuthUserView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        title = "Вход"
        navigationController?.navigationBar.layer.addShadow()
    }
    
    private func bindViewModel() {
        
        let output = viewModel.transform(
            input: .init(userPhone: rootView.phoneTextField.rx.text.asObservable(),
                         userPassword: rootView.passwordTextField.rx.text.asObservable(),
                         authTapped: rootView.authButton.rx.tap.asObservable()))
        
        let result = output.isLogged.publish()
        
        result.element
            .subscribe(onNext: { status in
                if status.Success == true {
                    self.authTapped?()
                    self.userSession.save(accessToken: status.Message, refreshToken: status.Message)
                } else {
                    self.showErrorInAlert(text: status.Message)
                }
            }).disposed(by: disposeBag)
        
        result.loading
            .bind(to: ProgressView.instance.rx.loading)
            .disposed(by: disposeBag)
        
        result.connect()
            .disposed(by: disposeBag)
        
        result.errors
            .bind(to: rx.error)
            .disposed(by: disposeBag)
        
        
        rootView.resetPasswordButton.rx.tap
            .subscribe(onNext: { [unowned self] in
                self.resetTapped?()
            })
            .disposed(by: disposeBag)
        
    }
    
    private func bindView() {
//        let filled = [
//            rootView.phoneTextField.isFilled,
//            rootView.passwordTextField.isFilled]
        
        
        
    }
}
