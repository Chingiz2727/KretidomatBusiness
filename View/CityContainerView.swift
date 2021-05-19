import UIKit
import InputMask

final class CityContainerView: UIView {
    private let pickerView = UIPickerView()
    
    lazy var title: UILabel = {
        let l = UILabel()
        l.font = .regular12
        l.textAlignment = .left
        return l
    }()
    
    lazy var buttonView: UIView = {
        let v = UIView()
        v.backgroundColor = .clear
        return v
    }()
    let cityListTextField = TextFieldContainer()
    
    let cityListImage : UIImageView = {
        let iv =  UIImageView()
        iv.image = Images.arrowbottom.image
        return iv
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
        
        addSubview(title)
        title.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(10)
        }
        
        addSubview(cityListTextField)
        cityListTextField.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview()
        }
        
        cityListTextField.addSubview(cityListImage)
        cityListImage.snp.makeConstraints { make in
            make.height.equalTo(8)
            make.width.equalTo(14)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(10)
        }
    }
    
    private func configureView() {
        cityListTextField.textField.delegate = listener
    }
}
