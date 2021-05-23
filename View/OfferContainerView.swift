import UIKit

final class OfferContainerView: UIView {
    
    let title: UILabel = {
        let l = UILabel()
        l.font = .regular12
        l.textColor = UIColor.gray.withAlphaComponent(0.4)
        l.textAlignment = .center
        return l
    }()
    
    let offerContractTitle: UILabel = {
        let l = UILabel()
        l.font = .regular13
        return l
    }()
    
    let buttonContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .primary
        view.layer.cornerRadius = 10
        return view
    }()
    
    let offerButton = OfferButton()
    
    let checkBox: UIButton = {
        let b = UIButton()
        b.setImage(Images.checkboxUnselected.image, for: .normal)
        b.backgroundColor = .clear
        return b
    }()
    
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
            make.top.equalToSuperview().inset(20)
            make.leading.trailing.equalToSuperview()
        }
        
        addSubview(checkBox)
        checkBox.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalTo(title.snp.bottom).offset(5)
            make.size.equalTo(35)
        }
        
        addSubview(offerContractTitle)
        offerContractTitle.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(15)
            make.left.equalTo(checkBox.snp.right).offset(10)
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
