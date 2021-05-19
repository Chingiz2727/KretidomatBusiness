import UIKit
import RxSwift

final class ResetPasswordViewController: ViewController, ViewHolder, ResetPasswordModule {
    
    var resetTapped: ResetTapped?
    private var viewModel: ResetPasswordViewModel!
    
    private let disposeBag = DisposeBag()
    typealias RootViewType = ResetPasswordView
    
    override func loadView() {
        view = ResetPasswordView()
        title = "Забыли пароль?"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ResetPasswordViewModel(apiService: assembler.resolver.resolve(AuthenticationService.self)!)
        bindViewModel()
    }
    
    private func bindViewModel() {
        let output = viewModel.transform(
            input: .init(phoneText: rootView.phoneTextField.rx.text.unwrap(),
                         emailText: rootView.emailTextField.rx.text.unwrap(),
                         resetTapped: rootView.resetButton.rx.tap.asObservable()))
        
        let result = output.resetTapped.publish()
        
        result.element
            .subscribe(onNext: { [unowned self] result in
                if result.Success == false {
                    self.showErrorInAlert(text: result.Message)
                } else {
                    self.resetTapped?()
                    self.presentCustomAlert(type: .recoverPass, secondButtonAction:  {
//                        self.hide
                    })
                }
            })
            .disposed(by: disposeBag)

        result.loading
            .bind(to: ProgressView.instance.rx.loading)
            .disposed(by: disposeBag)
        result.connect()
            .disposed(by: disposeBag)
    }
}
