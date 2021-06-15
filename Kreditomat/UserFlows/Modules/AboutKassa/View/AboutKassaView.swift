
import UIKit
import RxSwift

final class AboutKassaView: UIView {
    
    private let disposeBag = DisposeBag()
    var selectTag = BehaviorSubject.init(value: 0)
    
    let pointTitle: UILabel = {
        let l = UILabel()
        l.text = "Выберите точку"
        l.font = .regular12
        l.textAlignment = .left
        return l
    }()
 
    let pointListTextField = TextFieldContainer()
    
    let pointImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Images.arrowbottom.image
        return imageView
    }()
        
    let kassaOperationTitle: UILabel = {
        let l = UILabel()
        l.text = "Выберите желаемую кассовую операцию"
        l.textAlignment = .center
        l.font = .regular12
        l.textColor = UIColor.gray.withAlphaComponent(0.8)
        return l
    }()
    
    let refillButton: UIButton = {
        let b = UIButton()
        b.setTitle("ПОПОЛНЕНИЕ", for: .normal)
        b.backgroundColor = .primary
        b.layer.cornerRadius = 20
        b.titleLabel?.font = .regular15
        return b
    }()
    
    let withdrawalButton: UIButton = {
        let b = UIButton()
        b.backgroundColor = .primary
        b.layer.cornerRadius = 20
        b.setTitle("ИЗЪЯТИЕ", for: .normal)
        b.titleLabel?.font = .regular15
        return b
    }()
    
    let amountOperationTitle: UILabel = {
        let l = UILabel()
        l.text = "Укажите желаемую сумму для кассовой операции"
        l.font = .regular12
        l.textAlignment = .center
        l.textColor = UIColor.gray.withAlphaComponent(0.8)
        return l
    }()
    
    let amountOperationView = AmountOperationView()
    
    let infoLabel: UILabel = {
        let l = UILabel()
        l.text = "Минимальная сумма 50 000 тенге, максимальная сумма 1 000 000 тенге. Просим учесть, что каждый шаг при выборе суммы равен 10 000 тенге"
        l.font = .regular12
        l.textAlignment = .center
        l.textColor = UIColor.gray.withAlphaComponent(0.8)
        l.numberOfLines = 0
        return l
    }()
    
    let accessButton: UIButton = {
        let b = UIButton()
        b.backgroundColor = .primary
        b.layer.cornerRadius = 20
        b.setTitle("ПОДТВЕРДИТЬ", for: .normal)
        b.titleLabel?.font = .bold15
        return b
    }()
    
    lazy var pointStack = UIStackView(views: [pointTitle, pointListTextField], axis: .vertical, distribution: .fill, spacing: 5)
    
    lazy var buttonStack = UIStackView(views: [refillButton, withdrawalButton], axis: .horizontal, distribution: .fillEqually, spacing: 10)
    
    lazy var kassaOperationStack = UIStackView(views: [kassaOperationTitle, buttonStack], axis: .vertical, distribution: .fill, spacing: 5)
    
    lazy var amountStack = UIStackView(views: [amountOperationTitle, amountOperationView, infoLabel], axis: .vertical, distribution: .fill, spacing: 10)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInitialLayouts()
        configureView()
        configureButtonType()
    }

    required init?(coder: NSCoder) {
        nil
    }
    
    private func setupInitialLayouts() {
        addSubview(pointTitle)
        pointTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.leading.equalToSuperview().inset(30)
        }
        
        addSubview(pointListTextField)
        pointListTextField.snp.makeConstraints { make in
            make.top.equalTo(pointTitle.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
        addSubview(kassaOperationStack)
        kassaOperationStack.snp.makeConstraints { make in
            make.top.equalTo(pointListTextField.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        pointListTextField.snp.makeConstraints { $0.height.equalTo(40)}
        buttonStack.snp.makeConstraints { $0.height.equalTo(40)}
        
        pointListTextField.addSubview(pointImage)
        pointImage.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
            make.height.equalTo(8)
            make.width.equalTo(14)
        }
        
        addSubview(amountStack)
        amountStack.snp.makeConstraints { make in
            make.top.equalTo(buttonStack.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        amountOperationView.snp.makeConstraints { $0.height.equalTo(100)}
        
        addSubview(accessButton)
        accessButton.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview().inset(50)
            make.height.equalTo(40)
        }
        
    }
    
    private func configureView() {
        backgroundColor = .background
        pointListTextField.textField.placeholder = "Все.."
        amountOperationView.amountLabel.text = "СУММА"
        amountOperationView.amountTextField.placeholder = "10 000 тг"
        pointListTextField.layer.addShadow()
        refillButton.layer.addShadow()
        withdrawalButton.layer.addShadow()
        amountOperationView.layer.addShadow()
        accessButton.layer.addShadow()
        accessButton.isEnabled = true
    }
    
    func configureButtonType() {
        refillButton.tag = 1
        withdrawalButton.tag = 2
        let buttons = [refillButton, withdrawalButton]
        
        buttons.forEach { button in
            button.rx.controlEvent(.touchUpInside)
                .subscribe(onNext: { [unowned self] in
                    self.selectTag.onNext(button.tag)
                }).disposed(by: disposeBag)
        }
    }
    
    func configureButton(selected: Bool) {
        
        if selected == true {
            refillButton.backgroundColor = .secondary
            withdrawalButton.backgroundColor = .primary
        } else {
            withdrawalButton.backgroundColor = .secondary
            refillButton.backgroundColor = .primary
        }
    }
}
