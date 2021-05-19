import UIKit

final class AuthUserView: UIView {
    
    let phoneTitle: UILabel = {
        let label = UILabel()
        label.font = .regular12
        label.text = "Введите номер телефона"
        label.textAlignment = .center
        return label
    }()
    
    let phoneTextField = PhoneNumberTextField()
    
    let passwordTitle: UILabel = {
        let label = UILabel()
        label.font = .regular12
        label.text = "Введите пароль"
        label.textAlignment = .center
        return label
    }()
    
    let passwordTextField = PasswordTextField()
    
    let resetPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle("Забыли пароль?", for: .normal)
        button.setTitleColor(.resetPswdColor, for: .normal)
        button.titleLabel?.font = .regular12
        
        return button
    }()
    
    let authButton: UIButton = {
        let button = UIButton()
        button.setTitle("ВОЙТИ", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .regular12
        button.layer.cornerRadius = 20
        button.backgroundColor = .primary
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInitialLayouts()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    private func setupInitialLayouts() {
        backgroundColor = .white
        
        addSubview(phoneTitle)
        phoneTitle.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(40)
            make.center.equalTo(self).offset(-150)
        }
        
        addSubview(phoneTextField)
        phoneTextField.snp.makeConstraints { make in
            make.top.equalTo(phoneTitle.snp.bottom).offset(5)
            make.left.right.equalToSuperview().inset(50)
            make.height.equalTo(40)
        }
        
        addSubview(passwordTitle)
        passwordTitle.snp.makeConstraints { make in
            make.top.equalTo(phoneTextField.snp.bottom).offset(20)
            make.left.right.equalToSuperview()
            make.centerX.equalTo(self)
        }
        
        addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordTitle.snp.bottom).offset(5)
            make.left.right.equalToSuperview().inset(50)
            make.height.equalTo(40)
        }
        
        addSubview(resetPasswordButton)
        resetPasswordButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.right.equalToSuperview().inset(50)
        }
        
        addSubview(authButton)
        authButton.snp.makeConstraints { make in
            make.top.equalTo(resetPasswordButton.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(50)
            make.height.equalTo(40)
        }
    }
    
    private func configureView() {
        backgroundColor = .background
        phoneTextField.layer.borderWidth = 1.5
        phoneTextField.layer.addShadow()
        passwordTextField.placeholder = "Пароль"
        passwordTextField.layer.addShadow()
        passwordTextField.layer.borderWidth = 1.5
        authButton.layer.addShadow()
    }
}
   
