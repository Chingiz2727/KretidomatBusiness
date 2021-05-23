import UIKit
import InputMask
import RxSwift

final class PasswordTextField: RightButtonTextField {
    
    private let listener = MaskedTextFieldDelegate(primaryFormat: "[…]")
//    private let textSubject = PublishSubject<String>()
//    private let isFilledSubject = PublishSubject<Bool>()

//    public var cardText: Observable<String> {
//        textSubject
//    }

    
    override var isSecureTextEntry: Bool {
        didSet {
            let image = #imageLiteral(resourceName: "eye")
            setButtonImage(image: image.withRenderingMode(.alwaysOriginal))
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        configureDelegate()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
//        configureDelegate()
    }
    
//    override func configureDelegate() {
//        delegate = listener
//        listener.onMaskedTextChangedCallback = { [weak self] field, _, isFilled in
//            guard let text = field.text else { return }
//            self?.isFilled = isFilled
//            self?.textSubject.onNext(text)
//        }
//    }

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
