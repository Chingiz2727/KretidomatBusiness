import UIKit
import SnapKit
import RxSwift

final class AuthStateViewController: ViewController, ViewHolder, AuthStateModule {
    var signInTapped: SignInTapped?
    var signUpTapped: SignUpTapped?
    
    typealias RootViewType = AuthStateView
    
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        view = AuthStateView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    private func bindView() {
        rootView.logInButton.addTarget(self, action: #selector(loginTap), for: .touchUpInside)
        rootView.registerButton.addTarget(self, action: #selector(registerTap), for: .touchUpInside)
//        rootView.logInButton.rx.tap
//            .subscribe(onNext: { [unowned self] in
//                self.signInTapped?()
//            }).disposed(by: disposeBag)
//
//        rootView.registerButton.rx.tap
//            .subscribe(onNext:  { [unowned self] in
//                self.signUpTapped?()
//            }).disposed(by: disposeBag)
    }
    
    @objc private func loginTap() {
        signInTapped?()
    }
    
    @objc private func registerTap() {
        signUpTapped?()
    }
}
