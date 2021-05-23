import InputMask
import UIKit
import RxSwift

private enum Constants {
    static let textMask = "[0…]"
    static let prefixText = "№"
    static let prefixSpacing: CGFloat = 16
    static let dividerWidth: CGFloat = 1.5
    static let placeholder = "Номер"
}

final class NumberTextField: RegularTextField {
    
    var numberText: String {
        guard let fieldText = text else { return "" }
        let text = CaretString(string: fieldText, caretPosition: fieldText.endIndex, caretGravity: .forward(autocomplete: false))
        let extractedValue =
            listener.primaryMask.apply(toText: text).extractedValue
        return extractedValue
    }
    
    public var isFilled: Observable<Bool> {
        isFilledSubject
    }

    override var isEnabled: Bool {
        didSet {
            prefixLabel.textColor = currentState.textColor
            layer.borderColor = UIColor.primary.cgColor
        }
    }

    private let listener = MaskedTextFieldDelegate(primaryFormat: Constants.textMask)
    private let isFilledSubject = PublishSubject<Bool>()
    private let prefixLabel = UILabel()
    private let dividerView = UIView()
    
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
        setupInitialLayout()
        configureDelegate()
        configureTextStyle()
        configureColor()
    }
    
    private func setupInitialLayout() {
        addSubview(prefixLabel)
        addSubview(dividerView)
    }
    
    private func configureColor() {
        textColor = UIColor.black
        prefixLabel.textColor = UIColor.black
        dividerView.backgroundColor = UIColor.primary
    }
    
    private func configureTextStyle() {
        textContentType = .telephoneNumber
        keyboardType = .numberPad
        prefixLabel.font = .systemFont(ofSize: 13)
        font = .systemFont(ofSize: 13)
        placeholder = Constants.placeholder
        prefixLabel.text = Constants.prefixText
    }
    
    override func configureDelegate() {
        delegate = listener
        listener.onMaskedTextChangedCallback = { [weak self] _, _, isFilled in
            self?.isFilledSubject.onNext(isFilled)
        }
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let superRect = super.textRect(forBounds: bounds)
        return CGRect(
            x: superRect.origin.x + Constants.dividerWidth + prefixLabel.intrinsicContentSize.width
                + 1.5 * Constants.prefixSpacing,
            y: superRect.origin.y,
            width: frame.width - superRect.origin.x - prefixLabel.intrinsicContentSize.width
                - Constants.dividerWidth - Constants.prefixSpacing,
            height: superRect.height
        )
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let superRect = super.editingRect(forBounds: bounds)
        return CGRect(
            x: superRect.origin.x + 0.5 + prefixLabel.intrinsicContentSize.width
                + 1.5 * Constants.prefixSpacing,
            y: superRect.origin.y,
            width: frame.width - superRect.origin.x - prefixLabel.intrinsicContentSize.width -
                Constants.dividerWidth - Constants.prefixSpacing,
            height: superRect.height
        )
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect)
        updateInputFrame(forText: rect)
    }
    
    private func updateInputFrame(forText rect: CGRect) {
        let leadingSpace = min( Constants.prefixSpacing, frame.width - prefixLabel.intrinsicContentSize.width - 4)
        dividerView.center.y = rect.height / 2
        dividerView.frame.origin.x = leadingSpace + prefixLabel.intrinsicContentSize.width + Constants.prefixSpacing
        dividerView.frame.size.height = prefixLabel.intrinsicContentSize.height
        dividerView.frame.size.width = Constants.dividerWidth
        prefixLabel.center.y = rect.height / 2
        prefixLabel.frame.origin.x = leadingSpace
        prefixLabel.frame.size = prefixLabel.intrinsicContentSize
    }
}
