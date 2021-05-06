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
    
    private func bindView() {
        rootView.signInView.baseButton.rx.tap
            .subscribe(onNext: { [unowned self] in
                self.signInTapped?()
            }).disposed(by: disposeBag)
        
        rootView.signUpView.baseButton.rx.tap
            .subscribe(onNext: { [unowned self] in
                self.signUpTapped?()
            }).disposed(by: disposeBag)
    }
}
