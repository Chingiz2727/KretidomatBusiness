import UIKit

final class AmountOperationView: UIView {
    
    let containerView: UIView = {
        let v = UIView()
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor.primary.cgColor
        v.layer.cornerRadius = 10
        return v
    }()
    
    let amountTitleView: UIView = {
        let v = UIView()
        v.layer.cornerRadius = 10
        v.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        v.backgroundColor = .primary
        return v
    }()
    
    let amountLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 15)
        l.textAlignment = .center
        l.textColor = .white
        return l
    }()
    
    let amountTextField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .clear
        tf.keyboardType = .numberPad
        return tf
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInitialLayout()
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    private func setupInitialLayout() {
        addSubview(containerView)
        containerView.snp.makeConstraints { $0.edges.equalToSuperview()}
        
        containerView.addSubview(amountTitleView)
        amountTitleView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(40)
        }
        amountTitleView.addSubview(amountLabel)
        amountLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.leading.trailing.equalToSuperview()
        }
        
        
        containerView.addSubview(amountTextField)
        amountTextField.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(10)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
        }
    }
    
}
