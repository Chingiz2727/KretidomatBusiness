import UIKit

final class AuthUserView: UIView {
    
    let phoneTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .center
        return label
    }()
    
    let phoneTextField = PhoneNumberTextField()
    
    let passwordTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .center
        return label
    }()
    
    let passwordTextField = PasswordTextField()
    
    let resetPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
    
    let authButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 15
        button.backgroundColor = .primary
        return button
    }()
    
    lazy var verticalStackView = UIStackView(views: [phoneTitle, phoneTextField, UIView(), passwordTitle, passwordTextField], axis: .vertical, distribution: .fill, spacing: 5)
    
    
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
        
        addSubview(verticalStackView)
        verticalStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-60)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(180)
        }
        
        phoneTextField.snp.makeConstraints { $0.height.equalTo(Layout.textFieldHeight) }
        passwordTextField.snp.makeConstraints { $0.height.equalTo(Layout.textFieldHeight) }
        
        addSubview(resetPasswordButton)
        resetPasswordButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(70)
            make.trailing.equalToSuperview().inset(20)
        }
        
        addSubview(authButton)
        authButton.snp.makeConstraints { make in
            make.top.equalTo(resetPasswordButton.snp.bottom).offset(10)
            make.height.equalTo(Layout.buttonHeight)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    private func configureView() {
        phoneTitle.text = "Введите номер телефона"
        passwordTitle.text = "Введите пароль"
        resetPasswordButton.setTitle("Забыли пароль?", for: .normal)
        authButton.setTitle("ВОЙТИ", for: .normal)
    }
   
}
   
