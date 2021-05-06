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
    let signUpView = TitleAndButtonView()
    
    lazy var fullStackView = UIStackView(views: [signInView, signUpView], axis: .vertical, distribution: .fill, spacing: 10)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInitialLayouts()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    private func setupInitialLayouts() {
        addSubview(fullStackView)
        fullStackView.snp.makeConstraints { make in
            make.center.equalTo(safeAreaLayoutGuide.snp.center).inset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(140)
        }
        
        addSubview(titleText)
        titleText.snp.makeConstraints { make in
            make.bottom.equalTo(fullStackView.snp.top).offset(10)
            make.centerX.equalTo(fullStackView.snp.centerX)
        }
    }
    
    private func configureView() {
        titleText.text = "Добро пожаловать!"
        signInView.titleText.text = "У меня уже есть аккаунт"
        signInView.baseButton.setTitle("ВОЙТИ", for: .normal)
        signUpView.titleText.text = "У меня нет аккаунта"
        signUpView.baseButton.setTitle("ЗАРЕГИСТРИРОВАТЬСЯ", for: .normal)
    }
}
