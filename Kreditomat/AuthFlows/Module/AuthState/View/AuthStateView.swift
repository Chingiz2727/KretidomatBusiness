import UIKit
import SnapKit

final class AuthStateView: UIView {
    
    let titleText: UILabel = {
        let label = UILabel()
        label.font = .bold15
        label.textAlignment = .center
        label.text = "Добро пожаловать!"
        return label
    }()
    
    let logInTitle: UILabel = {
        let l = UILabel()
        l.text = "У меня уже есть аккаунт"
        l.font = .regular12
        return l
    }()
    
    let logInButton: UIButton = {
        let b = UIButton()
        b.setTitle("ВОЙТИ", for: .normal)
        b.setTitleColor(.white, for: .normal)
        b.layer.cornerRadius = 20
        b.backgroundColor = .primary
        return b
    }()

    let registerTitle : UILabel = {
        let l = UILabel()
        l.text = "У меня нет аккаунта"
        l.font = .regular12
        return l
    }()
    
    let registerButton : UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 20
        button.setTitle("ЗАРЕГИСТРИРОВАТЬСЯ", for: .normal)
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
        
        addSubview(titleText)
        titleText.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.center.equalTo(self).offset(-145)
        }

        addSubview(logInTitle)
        logInTitle.snp.makeConstraints { make in
            make.top.equalTo(titleText.snp.bottom).offset(45)
            make.centerX.equalTo(self)
        }
        
        addSubview(logInButton)
        logInButton.snp.makeConstraints { make in
            make.top.equalTo(logInTitle.snp.bottom).offset(5)
            make.left.right.equalToSuperview().inset(40)
            make.height.equalTo(40)
        }
        
        addSubview(registerTitle)
        registerTitle.snp.makeConstraints { make in
            make.top.equalTo(logInButton.snp.bottom).offset(25)
            make.centerX.equalTo(self)
        }
        
        addSubview(registerButton)
        registerButton.snp.makeConstraints { make in
            make.top.equalTo(registerTitle.snp.bottom).offset(5)
            make.left.right.equalToSuperview().inset(40)
            make.height.equalTo(40)
        }
    }
    
    private func configureView() {
        backgroundColor = .background
        logInButton.layer.addShadow()
        logInButton.titleLabel?.font = .regular15
        registerButton.layer.addShadow()
        registerButton.titleLabel?.font = .regular15
    }
}
