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

        textField.snp.makeConstraints { $0.edges.equalToSuperview() }

        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(textField.snp.top).offset(-5)
            make.leading.equalTo(textField.snp.leading).inset(5)
        }
    }

    func setTitleBackground(background: UIColor) {
        titleLabel.font = .regular10
        textField.backgroundColor = background
        backgroundColor = background
    }

    private func updateTitle() {
        titleLabel.font = .regular10
        titleLabel.text = title
        titleLabel.textColor = .black
        titleLabel.isHidden = title == nil
    }
}
