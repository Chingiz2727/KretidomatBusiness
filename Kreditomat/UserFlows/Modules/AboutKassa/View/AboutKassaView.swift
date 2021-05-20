import UIKit

final class AboutKassaView: UIView {
    
    let pointTitle: UILabel = {
        let l = UILabel()
        l.text = "Выберите точку"
        l.font = .regular14
        l.textAlignment = .left
        return l
    }()
 
    let pointListTextField = TextFieldContainer()
    
    let pointImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Images.arrowbottom.image
        return imageView
    }()
    
    let tableView = UITableView()
    
    let kassaOperationTitle: UILabel = {
        let l = UILabel()
        l.text = "Выберите желаемую кассовую операцию"
        l.textAlignment = .center
        l.font = .regular14
        l.textColor = UIColor.gray.withAlphaComponent(0.5)
        return l
    }()
    
    let refillButton: PrimaryButton = {
        let b = PrimaryButton()
        b.setTitle("ПОПОЛНЕНИЕ", for: .normal)
        return b
    }()
    
    let withdrawalButton: PrimaryButton = {
        let b = PrimaryButton()
        b.setTitle("ИЗЪЯТИЕ", for: .normal)
        return b
    }()
    
    let amountOperationTitle: UILabel = {
        let l = UILabel()
        l.text = "Укажите желаемую сумму для кассовой операции"
        l.font = .regular14
        l.textAlignment = .center
        l.textColor = UIColor.gray.withAlphaComponent(0.5)
        return l
    }()
    
    let amountOperationView = AmountOperationView()
    
    let infoLabel: UILabel = {
        let l = UILabel()
        l.text = "Минимальная сумма 50 000 тенге, максимальная сумма 1 000 000 тенге. Просим учесть, что каждый шаг при выборе суммы равен 10 000 тенге"
        l.font = .regular14
        l.textAlignment = .center
        l.textColor = UIColor.gray.withAlphaComponent(0.5)
        l.numberOfLines = 0
        return l
    }()
    
    let accessButton: PrimaryButton = {
        let b = PrimaryButton()
        b.setTitle("ПОДТВЕРДИТЬ", for: .normal)
        return b
    }()
    
    lazy var pointStack = UIStackView(views: [pointTitle, pointListTextField], axis: .vertical, distribution: .fill, spacing: 5)
    
    lazy var buttonStack = UIStackView(views: [refillButton, withdrawalButton], axis: .horizontal, distribution: .fillEqually, spacing: 10)
    
    lazy var kassaOperationStack = UIStackView(views: [kassaOperationTitle, buttonStack], axis: .vertical, distribution: .fill, spacing: 10)
    
    lazy var amountStack = UIStackView(views: [amountOperationTitle, amountOperationView, infoLabel], axis: .vertical, distribution: .fill, spacing: 10)
    
    lazy var mainStack = UIStackView(views: [pointStack, kassaOperationStack], axis: .vertical, distribution: .fill, spacing: 20)
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInitialLayouts()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    private func setupInitialLayouts() {
        addSubview(mainStack)
        mainStack.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        pointListTextField.snp.makeConstraints { $0.height.equalTo(Layout.textFieldHeight)}
        
        pointListTextField.addSubview(pointImage)
        pointImage.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
            make.height.equalTo(8)
            make.width.equalTo(14)
        }
        
        addSubview(amountStack)
        amountStack.snp.makeConstraints { make in
            make.top.equalTo(buttonStack.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        amountOperationView.snp.makeConstraints { $0.height.equalTo(100)}
        
        addSubview(accessButton)
        accessButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(40)
            make.height.equalTo(40)
        }
        
        refillButton.snp.makeConstraints { (make) in
            make.height.equalTo(40)
        }
        
        withdrawalButton.snp.makeConstraints { (make) in
            make.height.equalTo(40)
        }
        
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
//            make.top.equalTo(pointListTextField.snp.bottom).offset(20)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    private func configureView() {
        backgroundColor = .background
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.registerClassForCell(PointCell.self)
        tableView.rowHeight = 400
        pointListTextField.textField.placeholder = "Все.."
        amountOperationView.amountLabel.text = "СУММА"
        amountOperationView.amountTextField.placeholder = "10 000 тг"
        pointListTextField.layer.addShadow()
        refillButton.layer.addShadow()
        withdrawalButton.layer.addShadow()
        amountOperationView.layer.addShadow()
        accessButton.layer.addShadow()
    }
}
