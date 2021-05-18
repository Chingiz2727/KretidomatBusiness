import UIKit

final class OfferButton: BaseButton {
    
    let offerImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInitialLayouts()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    override func updateAppereance() {
        switch currentState {
        case .enabled:
            configureView()
        default:
            configureView()
        }
    }
    
    private func configureView() {
        backgroundColor = .clear
        layer.cornerRadius = 5
        
    }
    
    private func setupInitialLayouts() {
        addSubview(offerImage)
        offerImage.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(5)
            make.size.equalTo(20)
        }
    }
    
}
