import UIKit

final class CustomAlertView: UIView {
    
    private let backgroundView = UIView()
    private let logoImageView = UIImageView()
    private let headerView = UIView()
    let exitView = UIButton()
    private let titleLabel = UILabel()
    private let subtitleTitleLabel = UILabel()
    
    private let descriptionTitleLabel = UILabel()
    private let descriptionSubtitleLabel = UILabel()
    
    let acceptButton = PrimaryButton()
    let declineButton = PrimaryButton()
    
    private lazy var buttonsStackView = UIStackView(
        views: [acceptButton, declineButton],
        axis: .horizontal,
        distribution: .fillEqually,
        spacing: 10)
    
    private lazy var titleStackView = UIStackView(
        views: [titleLabel, subtitleTitleLabel],
        axis: .vertical,
        distribution: .fill,
        spacing: 2)
    
    private lazy var descriptionStackView = UIStackView(
        views: [descriptionTitleLabel, descriptionSubtitleLabel],
        axis: .vertical,
        distribution: .fill,
        spacing: 2)
    
    private lazy var fullStackView = UIStackView(
        views: [titleStackView, descriptionStackView, buttonsStackView],
        axis: .vertical,
        distribution: .fill,
        spacing: 15)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInitialLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupInitialLayout()
        configureView()
    }
    
    func configureByType(type: AlertType) {
        titleLabel.text = type.title
        subtitleTitleLabel.text = type.titleSubtitle
        descriptionTitleLabel.text = type.descriptionTitle
        descriptionSubtitleLabel.text = type.descriptionSubtitle
        acceptButton.isHidden = type.firstButtonHidden
        declineButton.isHidden = type.secondButtonHidden
        
        if type.firstButtonHidden == true && type.secondButtonHidden == true {
            buttonsStackView.isHidden = true
        }
        
        if type.firstButtonHidden == false && type.secondButtonHidden == false {
            acceptButton.setTitle("Да", for: .normal)
            declineButton.setTitle("Нет", for: .normal)
        } else {
            acceptButton.setTitle("Подтвердить", for: .normal)
        }
    }
    
    private func setupInitialLayout() {
        addSubview(backgroundView)
        
        backgroundView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(40)
        }
        
        backgroundView.addSubview(headerView)


        headerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(60)
        }
        
        headerView.addSubview(logoImageView)
        
        logoImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(10)
            make.width.equalTo(150)
        }
        
        backgroundView.addSubview(fullStackView)
        
        fullStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.top.equalTo(headerView.snp.bottom).offset(15)
            make.bottom.equalToSuperview().inset(10)
        }
        
        buttonsStackView.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        headerView.addSubview(exitView)
//        exitView.setImage(.init(named: "exit")?.withRenderingMode(.alwaysTemplate), for: .normal)
        exitView.setImage(UIImage(named: "exit")?.withRenderingMode(.alwaysTemplate), for: .normal)
        exitView.tintColor = .white
        exitView.imageView?.tintColor = .white
        exitView.snp.makeConstraints { make in
            make.top.right.equalToSuperview().inset(10)
            make.size.equalTo(20)
        }
    }
    
    private func configureView() {
        backgroundView.backgroundColor = .background
        backgroundView.layer.cornerRadius = 10
        headerView.layer.cornerRadius = 10
        headerView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        headerView.backgroundColor = .primary
        logoImageView.image = #imageLiteral(resourceName: "titleLogo")
        logoImageView.contentMode = .scaleAspectFit
        titleLabel.numberOfLines = 0
        subtitleTitleLabel.numberOfLines = 0
        descriptionTitleLabel.numberOfLines = 0
        descriptionSubtitleLabel.numberOfLines = 0
        titleLabel.font = .regular14
        descriptionTitleLabel.font = .regular14
        descriptionSubtitleLabel.font = .bold15
        subtitleTitleLabel.font = .regular14
        acceptButton.layer.cornerRadius = 20
        declineButton.layer.cornerRadius = 20
        backgroundColor = UIColor.black.withAlphaComponent(0.3)
        
        titleLabel.textAlignment = .center
        subtitleTitleLabel.textAlignment = .center
        descriptionTitleLabel.textAlignment = .center
        descriptionSubtitleLabel.textAlignment = .center
    }
}
