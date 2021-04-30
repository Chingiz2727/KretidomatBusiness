import UIKit

private enum Constants {
    static let buttonWidth: CGFloat = 22
    static let buttonHeight: CGFloat = 20
    static let rightSpacing: CGFloat = -17
}

class RightButtonTextField: RegularTextField {

    var buttonAction: (() -> Void)?
    
    override var isEnabled: Bool {
        didSet {
            currentState = .normal
        }
    }
    
    private let button: UIButton = {
        let button = UIButton()
        return button
    }()
    
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
            x: superRect.origin.x,
            y: 0,
            width: superRect.width - Constants.buttonWidth + Constants.rightSpacing - 16,
            height: superRect.height
        )
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let superRect = super.editingRect(forBounds: bounds)
        return CGRect(
            x: superRect.origin.x,
            y: 0,
            width: superRect.width - Constants.buttonWidth + Constants.rightSpacing - 16,
            height: superRect.height
        )
    }

    func setButtonImage(image: UIImage?, tintColor: UIColor = .lightGray) {
        button.setImage(image, for: .normal)
        button.tintColor = tintColor
    }
    
    @objc
    private func buttonTouchHandler() {
        buttonAction?()
    }
    
    private func configureView() {
        setupInitialLayout()
        button.addTarget(self, action: #selector(buttonTouchHandler), for: .touchUpInside)
        button.imageView?.contentMode = .scaleAspectFit
    }

    private func setupInitialLayout() {
        addSubview(button)
        button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.rightSpacing).isActive = true
        button.setCenterYConstraint(by: self)
        button.setSizeConstraints(width: Constants.buttonWidth, height: Constants.buttonHeight)
    }
}
