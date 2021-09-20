import InputMask
import UIKit
import RxSwift

private enum Constants {
    static let textMask = "[0000]-[00]-[00]"
    static let prefixText = "+7"
    static let prefixSpacing: CGFloat = 16
    static let dividerWidth: CGFloat = 2
    static let placeholder = "0000-00-00"
}

final class DateTextField: RegularTextField {
    
    var phoneNumberText: String {
        guard let fieldText = text else { return "" }
        let text = CaretString(string: fieldText, caretPosition: fieldText.endIndex, caretGravity: .forward(autocomplete: false))
        let extractedValue =
            listener.primaryMask.apply(toText: text).extractedValue
        return extractedValue
    }

    var phoneTextObservable: Observable<String> {
        return phoneTextSubject
    }
    
   private var phoneTextSubject: PublishSubject<String> = .init()
    
    var isFilled: Observable<Bool> {
        filledSubject
    }
    
    private let listener = MaskedTextFieldDelegate(primaryFormat: Constants.textMask)
    private let filledSubject = PublishSubject<Bool>()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    func setValue(phone: String) {
        listener.put(text: phone, into: self)
    }
    
    private func configureView() {
        configureDelegate()
        configureTextStyle()
        configureColor()
    }
    
    private func configureColor() {
        textColor = UIColor.black
    }
    
    private func configureTextStyle() {
        textContentType = .telephoneNumber
        keyboardType = .numberPad
        font = .systemFont(ofSize: 13)
        placeholder = Constants.placeholder
    }
    
    override func configureDelegate() {
        delegate = listener
        listener.onMaskedTextChangedCallback = { [weak self] _, phoneText, isFilled in
            self?.filledSubject.onNext(isFilled)
            self?.phoneTextSubject.onNext(phoneText)
        }
    }

}
