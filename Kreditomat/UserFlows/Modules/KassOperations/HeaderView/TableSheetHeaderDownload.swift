import UIKit

final class TableSheetHeaderDownload: UIView {
    private let titleLabel = UILabel()
    private let downloadButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInitialLayout()
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    private func setupInitialLayout() {
        addSubview(titleLabel)
        addSubview(downloadButton)
        
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        downloadButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(20)
            make.size.equalTo(20)
            make.top.bottom.equalToSuperview().inset(10)
        }
        
        backgroundColor = .primary
        downloadButton.imageView?.contentMode = .scaleAspectFit
        downloadButton.imageView?.tintColor = .white
        downloadButton.setImage(#imageLiteral(resourceName: "download"), for: .normal)
        titleLabel.textAlignment = .center
        titleLabel.text = "Отчет по кассовым операциям"
        titleLabel.textColor = .white
        titleLabel.font = .boldSystemFont(ofSize: 13)
    }
}
