import UIKit

final class TitleAndButtonView: UIView {

    lazy var titleText: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 10)
        l.textAlignment = .center
        return l
    }()
        
    lazy var baseButton: UIButton = {
        let b = UIButton()
        b.layer.cornerRadius = 20
        b.backgroundColor = .primary
        b.setTitleColor(.white, for: .normal)
        return b
    }()
    
    lazy var mainStack = UIStackView(views: [titleText, baseButton], axis: .vertical, distribution: .equalSpacing, spacing: 5)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(mainStack)
        mainStack.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        
        baseButton.snp.makeConstraints { $0.height.equalTo(Layout.buttonHeight - 10) }
    }
    
    required init?(coder: NSCoder) {
        nil
    }
}
