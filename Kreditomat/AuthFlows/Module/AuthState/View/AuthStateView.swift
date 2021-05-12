import UIKit
import SnapKit

final class AuthStateView: UIView {
    
    let titleText: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        return label
    }()
    
    let signInView = TitleAndButtonView()

    let signUpView = UIView()
    let registerTitle : UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 12)
        l.textAlignment = .center
        return l
    }()
    
    let registerButton : UIButton = {
        let button = UIButton()
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
        
        addSubview(signInView)
        signInView.snp.makeConstraints { make in
            make.center.equalToSuperview().inset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(80)
        }
        
        addSubview(signUpView)
        signUpView.snp.makeConstraints { make in
            make.top.equalTo(signInView.snp.bottom).offset(20)
            make.height.equalTo(80)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        signUpView.addSubview(registerTitle)
        registerTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.leading.trailing.equalToSuperview()
        }
        
        signUpView.addSubview(registerButton)
        registerButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(registerTitle.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview()
        }
        
        addSubview(titleText)
        titleText.snp.makeConstraints { make in
            make.bottom.equalTo(signInView.snp.top).offset(10)
            make.centerX.equalTo(signInView.snp.centerX).offset(20)
        }
    }
    
    private func configureView() {
        titleText.text = "Добро пожаловать!"
        signInView.titleText.text = "У меня уже есть аккаунт"
        signInView.baseButton.setTitle("ВОЙТИ", for: .normal)
        registerTitle.text = "У меня нет аккаунта"
        registerButton.setTitle("ЗАРЕГИСТРИРОВАТЬСЯ", for: .normal)
    }
}
