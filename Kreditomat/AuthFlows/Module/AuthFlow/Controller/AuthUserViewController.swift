import UIKit
import RxSwift

final class AuthUserViewController: ViewController, ViewHolder, AuthUserModule {
    
    typealias RootViewType = AuthUserView
    
    override func loadView() {
        view = AuthUserView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    private func bindViewModel() {
        
    }
    
}
