import UIKit

final class TextFieldContainer<T: RegularTextField>: UIView {
    let textField = T()

    var title: String? {
        didSet {
            updateTitle()
        }
    }

    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 12)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInitialLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupInitialLayout() {
        addSubview(textField)
        addSubview(titleLabel)

        textField.font = .systemFont(ofSize: 15)

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(1)
            make.leading.equalToSuperview()
        }
        
        textField.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
        }

        
    }

    func setTitleBackground(background: UIColor) {
        backgroundColor = background
    }

    private func updateTitle() {
        titleLabel.text = title
        titleLabel.textColor = .lightGray
        titleLabel.isHidden = title == nil
    }
}
