import UIKit

private enum Constants {
    static let cornerRadius: CGFloat = 12
    static let borderWidth: CGFloat = 0.5
}

class RegularTextField: UITextField {
    
    var currentState: RegularTextFieldState  = .normal {
        didSet {
            backgroundColor = currentState.backgroundColor
            layer.borderColor = currentState.borderColor
            textColor = currentState.textColor
            font = currentState.textFont
        }
    }
    
    override var placeholder: String? {
        didSet {
            configurePlaceholder()
        }
    }
    
    private let placeholderColor: UIColor = .lightGray
    private let placeholderFont: UIFont = .systemFont(ofSize: 14)
    
    override var isEnabled: Bool {
        didSet {
            if !isEnabled {
                currentState = .disabled
            } else {
                currentState = .normal
            }
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
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let superRect = super.textRect(forBounds: bounds)
        return CGRect(
            x: superRect.origin.x + 18,
            y: superRect.origin.y,
            width: superRect.width - 16,
            height: superRect.height
        )
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let superRect = super.editingRect(forBounds: bounds)
        return CGRect(
            x: superRect.origin.x + 18,
            y: superRect.origin.y,
            width: superRect.width - 16,
            height: superRect.height
        )
    }
    
    private func configureView() {
        configurePlaceholder()
        clipsToBounds = true
        layer.cornerRadius = Constants.cornerRadius
        layer.borderWidth = Constants.borderWidth
        tintColor = .primary
        currentState = .normal
        setActions()
    }
    
    private func configurePlaceholder() {
        attributedPlaceholder = NSAttributedString(string: placeholder ?? "",
                                                   attributes: [
                                                    NSAttributedString.Key.foregroundColor: placeholderColor,
                                                    NSAttributedString.Key.font: placeholderFont])
    }
    
    private func setActions() {
        addTarget(self, action: #selector(editingDidBegin), for: .editingDidBegin)
        addTarget(self, action: #selector(editingDidChanged), for: .editingChanged)
        addTarget(self, action: #selector(editingDidEnd), for: .editingDidEnd)
    }
    
    @objc
    private func editingDidBegin() {
        currentState = .selected
    }
    
    @objc
    private func editingDidChanged() {
        currentState = .selected
    }
    
    @objc
    private func editingDidEnd() {
        currentState = .normal
    }
}
