import UIKit

final class PasswordTextField: RightButtonTextField {
    
    override var isSecureTextEntry: Bool {
        didSet {
            let image = #imageLiteral(resourceName: "eye")
            setButtonImage(image: image.withRenderingMode(.alwaysOriginal))
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }

    private func toggleSecureEntry() {
        isSecureTextEntry.toggle()
        if let textRange = textRange(from: beginningOfDocument, to: endOfDocument) {
            replace(textRange, withText: text!)
        }
    }
    
    private func configureView() {
        textContentType = .password
        isSecureTextEntry = true
        buttonAction = toggleSecureEntry
    }
}
