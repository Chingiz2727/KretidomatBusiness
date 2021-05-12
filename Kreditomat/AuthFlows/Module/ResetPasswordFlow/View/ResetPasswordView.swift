import UIKit

final class ResetPasswordView: UIView {
    
    let infoLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 10)
        l.textColor = UIColor.gray.withAlphaComponent(0.5)
        l.numberOfLines = 0
        l.textAlignment = .center
        return l
    }()
    
    let phoneTitle: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 12)
        l.textAlignment = .center
        return l
    }()
    
    let phoneTextField: PhoneNumberTextField = {
        let tf = PhoneNumberTextField()
        tf.currentState = .normal
        tf.keyboardType = .numberPad
        tf.font = UIFont.systemFont(ofSize: 12)
        return tf
    }()
    
    let emailTitle: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 12)
        l.textAlignment = .center
        return l
    }()
    
    let emailTextField: RegularTextField = {
        let tf = RegularTextField()
        tf.currentState = .normal
        tf.keyboardType = .emailAddress
        tf.font = UIFont.systemFont(ofSize: 12)
        return tf
    }()
    
    let resetButton: UIButton = {
        let b = UIButton()
        b.backgroundColor = .primary
        b.layer.cornerRadius = Layout.cornerRadius
        b.setTitleColor( .white, for: .normal)
        return b
    }()
    
    lazy var mainStack = UIStackView(views: [phoneTitle, phoneTextField, emailTitle, emailTextField], axis: .vertical, distribution: .fillProportionally, spacing: 5)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInitialLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    private func setupInitialLayout() {
        addSubview(infoLabel)
        infoLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(10)
        }
        
        addSubview(mainStack)
        mainStack.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(25)
            make.height.equalTo(180)
        }
        
        phoneTextField.snp.makeConstraints { $0.height.equalTo(Layout.textFieldHeight)}
        emailTextField.snp.makeConstraints { $0.height.equalTo(Layout.textFieldHeight)}
        
        addSubview(resetButton)
        resetButton.snp.makeConstraints { make in
            make.top.equalTo(mainStack.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(25)
            make.height.equalTo(Layout.buttonHeight)
        }
    }
    
    private func configureView() {
        backgroundColor = .white
        infoLabel.text = "Если вы забыли пароль или вам не удается войти в личный кабинет, просим вас указать необходимые данные и отправить заявку на восстановление пароля"
        
        phoneTitle.text = "Введите свой номер телефона"
        phoneTextField.placeholder = "Укажите номер телефона"
        emailTitle.text = "Введите свою почту"
        emailTextField.placeholder = "Укажите вашу почту"
        resetButton.setTitle("ОТПРАВИТЬ", for: .normal)
    }
}
