import UIKit
import InputMask

final class CityContainerView: UIView {
    private let pickerView = UIPickerView()
    
    lazy var title: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 12)
        l.textAlignment = .left
        return l
    }()
    
    lazy var buttonView: UIView = {
        let v = UIView()
        v.backgroundColor = .clear
        return v
    }()
    
    lazy var cityTextField: RegularTextField = {
        let tf = RegularTextField()
        tf.layer.borderColor = UIColor.error.cgColor
        tf.layer.borderWidth = 1
        tf.placeholder = "Город"
        tf.backgroundColor = .clear
        return tf
    }()
    
    lazy var chooseButton: UIButton = {
        let b = UIButton()
        b.setImage(#imageLiteral(resourceName: "arrowbottom").withRenderingMode(.alwaysOriginal), for: .normal)
        b.contentMode = .scaleAspectFit
        return b
    }()
    
    let listener = MaskedTextFieldDelegate(primaryFormat: "[A…]")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInitialLayouts()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupInitialLayouts() {
        
        buttonView.addSubview(chooseButton)
        chooseButton.snp.makeConstraints { make in
            make.height.equalTo(8)
            make.width.equalTo(14)
            make.centerX.equalToSuperview()
            make.trailing.equalToSuperview().inset(10)
        }
        
        addSubview(title)
        title.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        
        addSubview(cityTextField)
        cityTextField.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(Layout.textFieldHeight)
        }
    }
    
    private func configureView() {
        cityTextField.delegate = listener
    }
}
