import RxSwift
import RxCocoa
import UIKit

extension Reactive where Base : UIButton {
    public var valid: Binder<Bool> {
        return Binder(self.base) { button, valid in
            button.isEnabled = valid
            button.backgroundColor = valid ? UIColor.gray.withAlphaComponent(0.5) : UIColor.primary
        }
    }
}

extension String {
    func validEmail() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predice = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return predice.evaluate(with: self)
    }
}
