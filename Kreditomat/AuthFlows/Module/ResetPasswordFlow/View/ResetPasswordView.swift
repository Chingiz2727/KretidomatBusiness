import UIKit

final class ResetPasswordView: UIView {
    
    let infoLabel: UILabel = {
        let l = UILabel()
        l.text = "Если вы забыли пароль или вам не удается войти в личный кабинет, просим вас указать необходимые данные и отправить заявку на восстановление пароля"
        l.font = .regular12
        l.textColor = UIColor.gray.withAlphaComponent(0.7)
        l.numberOfLines = 0
        l.textAlignment = .center
        return l
    }()
    
    let phoneTitle: UILabel = {
        let l = UILabel()
        l.text = "Введите свой номер телефона"
        l.font = .regular12
        l.textAlignment = .center
        return l
    }()
    
    let phoneTextField: PhoneNumberTextField = {
        let tf = PhoneNumberTextField()
        tf.placeholder = "Укажите номер телефона"
        tf.currentState = .normal
        tf.keyboardType = .numberPad
        tf.font = .regular12
        return tf
    }()
    
    let emailTitle: UILabel = {
        let l = UILabel()
        l.text = "Введите свою почту"
        l.font = .regular12
        l.textAlignment = .center
        return l
    }()
    
    let emailTextField: RegularTextField = {
        let tf = RegularTextField()
        tf.placeholder = "Почта"
        tf.currentState = .normal
        tf.keyboardType = .emailAddress
        tf.font = .regular12
        return tf
    }()
    
    let resetButton: UIButton = {
        let b = UIButton()
        b.setTitle("ОТПРАВИТЬ", for: .normal)
        b.setTitleColor( .white, for: .normal)
        b.titleLabel?.font = .regular12
        b.backgroundColor = .primary
        b.layer.cornerRadius = 20
        return b
    }()
    
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
            make.top.equalToSuperview().inset(20)
            make.left.right.equalToSuperview().inset(10)
        }
        
        addSubview(phoneTitle)
        phoneTitle.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(50)
            make.center.equalTo(self).offset(-135)
        }
        
        addSubview(phoneTextField)
        phoneTextField.snp.makeConstraints { make in
            make.top.equalTo(phoneTitle.snp.bottom).offset(5)
            make.left.right.equalToSuperview().inset(50)
            make.height.equalTo(40)
        }
        
        addSubview(emailTitle)
        emailTitle.snp.makeConstraints { make in
            make.top.equalTo(phoneTextField.snp.bottom).offset(20)
            make.centerX.equalTo(self)
        }
        
        addSubview(emailTextField)
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTitle.snp.bottom).offset(5)
            make.left.right.equalToSuperview().inset(50)
            make.height.equalTo(40)
        }
        
        addSubview(resetButton)
        resetButton.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(60)
            make.left.right.equalToSuperview().inset(50)
            make.height.equalTo(40)
        }
    }
    
    private func configureView() {
        backgroundColor = .background
        phoneTextField.layer.addShadow()
        emailTextField.layer.addShadow()
        resetButton.layer.addShadow()
        
    }
}
