import UIKit

final class OfferContainerView: UIView {
    
    let title: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 10)
        l.textColor = UIColor.gray.withAlphaComponent(0.4)
        l.textAlignment = .center
        return l
    }()
    
    let offerContractTitle: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 12)
        l.textAlignment = .center
        return l
    }()
    
    let buttonContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .primary
        view.layer.cornerRadius = Layout.cornerRadius
        return view
    }()
    
    let offerButton = OfferButton()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInitialLayouts()
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    private func setupInitialLayouts() {
        backgroundColor = .background
        addSubview(title)
        title.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.leading.trailing.equalToSuperview()
            
        }
        
        addSubview(offerContractTitle)
        offerContractTitle.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(20)
            make.centerX.equalToSuperview().inset(-10)
        }
        
        addSubview(buttonContainerView)
        buttonContainerView.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.size.equalTo(40)
            make.top.equalTo(title.snp.bottom).offset(5)
        }
        
        buttonContainerView.addSubview(offerButton)
        offerButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(25)
        }
    }
    
    func configureView(titleText: String, offerTitle: String, image: UIImage) {
        title.text = titleText
        offerContractTitle.text = offerTitle
        offerButton.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
    }
}
