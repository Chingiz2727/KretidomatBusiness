import UIKit

final class CustomAlertView: UIView {
    
    private let backgroundView = UIView()
    private let logoImageView = UIImageView()
    private let headerView = UIView()
    
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
        distribution: .fillEqually,
        spacing: 2)
    
    private lazy var descriptionStackView = UIStackView(
        views: [descriptionTitleLabel, descriptionSubtitleLabel],
        axis: .vertical,
        distribution: .fillEqually,
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
            make.leading.trailing.bottom.equalToSuperview().inset(15)
            make.top.equalTo(headerView.snp.bottom).offset(15)
        }
        
        buttonsStackView.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
    }
    
    private func configureView() {
        backgroundView.backgroundColor = .background
        backgroundView.layer.cornerRadius = 10
        headerView.layer.cornerRadius = 10
        headerView.backgroundColor = .primary
        logoImageView.image = #imageLiteral(resourceName: "titleLogo")
        logoImageView.contentMode = .scaleAspectFit
        titleLabel.numberOfLines = 0
        subtitleTitleLabel.numberOfLines = 0
        descriptionTitleLabel.numberOfLines = 0
        descriptionSubtitleLabel.numberOfLines = 0
        titleLabel.font = .systemFont(ofSize: 14)
        descriptionTitleLabel.font = .systemFont(ofSize: 14)
        descriptionSubtitleLabel.font = .boldSystemFont(ofSize: 14)
        subtitleTitleLabel.font = .boldSystemFont(ofSize: 14)
        acceptButton.layer.cornerRadius = 20
        declineButton.layer.cornerRadius = 20
        backgroundColor = .black.withAlphaComponent(0.3)
        
        titleLabel.text = "it's title"
        titleLabel.textAlignment = .center
        subtitleTitleLabel.text = "it's subtitle title"
        subtitleTitleLabel.textAlignment = .center
        descriptionTitleLabel.text = "it's description title"
        descriptionTitleLabel.textAlignment = .center
        descriptionSubtitleLabel.text = "it's description subtitle"
        descriptionSubtitleLabel.textAlignment = .center
        acceptButton.setTitle("accept", for: .normal)
        declineButton.setTitle("decline", for: .normal)
    }
}
