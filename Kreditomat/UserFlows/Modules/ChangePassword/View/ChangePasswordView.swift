import UIKit
import InputMask

final class ChangePasswordView: UIView {
    
    let oldPasswordTitle: UILabel = {
        let l = UILabel()
        l.text = "Введите старый пароль"
        l.font = .regular12
        return l
    }()
    
    let oldPassword = PasswordTextField()
    
    let newPasswordTitle: UILabel = {
        let l = UILabel()
        l.text = "Введите новый пароль"
        l.font = .regular12
        return l
    }()
    
    let newPassword = PasswordTextField()
    
    let repeatNewPasswordTitle: UILabel = {
        let l = UILabel()
        l.text = "Повторите новый пароль"
        l.font = .regular12
        return l
    }()
    
    let repeatNewPassword = PasswordTextField()
    
    let resetPassword : UIButton = {
        let b = UIButton()
        b.setTitle("Забыли пароль?", for: .normal)
        b.setTitleColor(.resetPswdColor, for: .normal)
        b.titleLabel?.font = .regular12
        return b
    }()
    
    let changePasswordButton: UIButton = {
        let b = UIButton()
        b.setTitle("ИЗМЕНИТЬ ПАРОЛЬ", for: .normal)
        b.setTitleColor(.white, for: .normal)
        b.titleLabel?.font = .bold12
        b.layer.cornerRadius = 20
        b.backgroundColor = .primary
        return b
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
        addSubview(oldPasswordTitle)
        oldPasswordTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.left.equalToSuperview().inset(30)
        }
        
        addSubview(oldPassword)
        oldPassword.snp.makeConstraints { make in
            make.top.equalTo(oldPasswordTitle.snp.bottom).offset(5)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
        addSubview(newPasswordTitle)
        newPasswordTitle.snp.makeConstraints { make in
            make.top.equalTo(oldPassword.snp.bottom).offset(15)
            make.left.equalTo(oldPasswordTitle.snp.left)
        }
        
        addSubview(newPassword)
        newPassword.snp.makeConstraints { make in
            make.top.equalTo(newPasswordTitle.snp.bottom).offset(5)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
        addSubview(repeatNewPasswordTitle)
        repeatNewPasswordTitle.snp.makeConstraints { make in
            make.top.equalTo(newPassword.snp.bottom).offset(15)
            make.left.equalTo(newPasswordTitle.snp.left)
        }
        
        addSubview(repeatNewPassword)
        repeatNewPassword.snp.makeConstraints { make in
            make.top.equalTo(repeatNewPasswordTitle.snp.bottom).offset(5)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
        addSubview(resetPassword)
        resetPassword.snp.makeConstraints { make in
            make.top.equalTo(repeatNewPassword.snp.bottom).offset(30)
            make.right.equalToSuperview().inset(20)
        }
        
        addSubview(changePasswordButton)
        changePasswordButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(40)
            make.height.equalTo(40)
            make.left.right.equalToSuperview().inset(20)
        }
        
    }
    
    private func configureView() {
        backgroundColor = .background
        oldPassword.currentState = .normal
        oldPassword.layer.addShadow()
        newPassword.currentState = .normal
        newPassword.layer.addShadow()
        repeatNewPassword.currentState = .normal
        repeatNewPassword.layer.addShadow()
    }
}
