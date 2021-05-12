import UIKit
import RxSwift

final class ResetPasswordViewController: ViewController, ViewHolder, ResetPasswordModule {
    
    var resetTapped: ResetTapped?
    
    typealias RootViewType = ResetPasswordView
    
    override func loadView() {
        view = ResetPasswordView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func bindViewModel() {
        
    }
    
    
}
