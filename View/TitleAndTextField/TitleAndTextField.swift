import UIKit

class TitleAndTextField: UIView {
    
    let title: UILabel = {
        let label = UILabel()
        label.font = .regular12
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    lazy var textField: RegularTextField = {
        let tf = RegularTextField()
        tf.layer.borderColor = UIColor.error.cgColor
        tf.backgroundColor = .white
        tf.layer.borderWidth = 1
        return tf
    }()
    
    let rightTitle: UILabel = {
        let l = UILabel()
        l.font = .regular12
        l.textColor = .error
        l.textAlignment = .right
        l.isHidden = true
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(title)
        title.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(10)
        }
        addSubview(textField)
        textField.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview()
        }
        
        addSubview(rightTitle)
        rightTitle.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    func configureTexts(placeHolderText: String, titleText: String) {
        title.text = titleText
        textField.placeholder = placeHolderText
    }
}
