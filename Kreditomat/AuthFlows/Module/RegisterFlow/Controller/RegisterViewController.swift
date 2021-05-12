import UIKit
import RxSwift

final class RegisterViewController: ViewController, ViewHolder, RegisterModule {    
    typealias RootViewType = RegisterView
    
    override func loadView() {
        view = RegisterView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    private func bindViewModel() {
        
    }
    
}
