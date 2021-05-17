import UIKit
import InputMask

final class RegisterView: UIView {
    
    private let scrollView = UIScrollView()
    let tableView = UITableView()
    var isSelected : Bool = false {
        didSet {
            if isSelected == true {
                offerView.checkBox.setImage(Images.checkboxSelected.image, for: .normal)
                registerButton.backgroundColor = .primary
                registerButton.isEnabled = true
            } else {
                offerView.checkBox.setImage(Images.checkboxUnselected.image, for: .normal)
                registerButton.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
                registerButton.isEnabled = false
            }
        }
    }
    
    let chooseFormTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textAlignment = .center
        return label
    }()
    
    let ipButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 20
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .primary
        return button
    }()
   
    let tooButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 20
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .secondary
        return button
    }()
    
    let cityView = CityContainerView()
    
    let numberHouseTitle: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 12)
        l.textAlignment = .left
        return l
    }()

    let numberOfficeTitle: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 12)
        l.textAlignment = .left
        return l
    }()
    
    let numberHouse: NumberTextField = {
        let tf = NumberTextField()
        tf.currentState = .error
        tf.placeholder = "Номер дома"
        return tf
    }()
    
    let numberOffice: NumberTextField = {
        let tf = NumberTextField()
        tf.currentState = .error
        tf.placeholder = "Номер офиса"
        return tf
    }()
    
    let nameUserView = TitleAndTextField()
    let binUserView = TitleAndTextField()
    let streetView = TitleAndTextField()
    
    let phoneView = UIView()
    let phoneNumberTitle: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 12)
        l.textAlignment = .left
        return l
    }()
    
    let numberPhoneTextField: PhoneNumberTextField = {
        let tf = PhoneNumberTextField()
        tf.currentState = .error
        return tf
    }()
    
    let emailView = UIView()
    
    let emailTitle: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 12)
        l.textAlignment = .left
        return l
    }()
    
    let emailTextField: RegularTextField = {
        let tf = RegularTextField()
        tf.currentState = .error
        tf.keyboardType = .emailAddress
        return tf
    }()
    
    let coordinateView = UIView()
    let coordinateTitle: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 12)
        l.textAlignment = .left
        return l
    }()
    
    let coordinateTextField: RegularTextField = {
        let tf = RegularTextField()
        tf.currentState = .error
        return tf
    }()
    
    let coordinateButtonView: UIView = {
        let b = UIButton()
        b.backgroundColor = .primary
        b.layer.cornerRadius = Layout.cornerRadius
        return b
    }()
    
    let coordinateButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "mapIcon").withRenderingMode(.alwaysOriginal), for: .normal)
        button.contentMode = .scaleAspectFit
        button.backgroundColor = .primary
        button.layer.cornerRadius = 5
        return button
    }()
    
    let offerView = OfferContainerView()
    
    let registerButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 20
        button.isEnabled = false
        button.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    lazy var numberHouseStack = UIStackView(views: [numberHouseTitle, numberHouse], axis: .vertical, distribution: .fill, spacing: 0)

    lazy var numberOfficeStack = UIStackView(views: [numberOfficeTitle, numberOffice], axis: .vertical, distribution: .fill, spacing: 0)
    
    lazy var buttonStack = UIStackView(views: [ipButton, tooButton], axis: .horizontal, distribution: .fillEqually, spacing: 10)
    
    lazy var addressStackView = UIStackView(views: [cityView, streetView], axis: .horizontal, distribution: .fillEqually, spacing: 5)
    
    lazy var numberStackView = UIStackView(views: [numberHouseStack, numberOfficeStack], axis: .horizontal, distribution: .fillEqually, spacing: 5)
    
    lazy var emailStack = UIStackView(views: [emailTitle, emailTextField], axis: .vertical, distribution: .fill, spacing: 5)

    lazy var fullStackView = UIStackView(views: [chooseFormTitle, buttonStack, nameUserView, binUserView, addressStackView, numberStackView, phoneView, emailStack, coordinateView, offerView, registerButton], axis: .vertical, distribution: .fill, spacing: 5)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInitialLayouts()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    private func setupInitialLayouts() {
        addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.leading.trailing.bottom.equalToSuperview()
        }
        scrollView.alwaysBounceVertical = true
        scrollView.showsHorizontalScrollIndicator = false
        
        scrollView.addSubview(fullStackView)
        fullStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.leading.trailing.width.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(30)
        }
        
        phoneView.addSubview(phoneNumberTitle)
        phoneNumberTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.leading.trailing.equalToSuperview()
        }
        
        phoneView.addSubview(numberPhoneTextField)
        numberPhoneTextField.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberTitle.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview()
        }
        
        coordinateView.addSubview(coordinateTitle)
        coordinateTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.leading.equalToSuperview()
        }
        
        coordinateView.addSubview(coordinateTextField)
        coordinateTextField.snp.makeConstraints { make in
            make.top.equalTo(coordinateTitle.snp.bottom).offset(5)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview().inset(70)
            make.height.equalTo(Layout.textFieldHeight)
        }
        
        coordinateView.addSubview(coordinateButtonView)
        coordinateButtonView.snp.makeConstraints { make in
            make.top.equalTo(coordinateTextField.snp.top)
            make.size.equalTo(40)
            make.trailing.equalToSuperview()
        }
        
        coordinateButtonView.addSubview(coordinateButton)
        coordinateButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(25)
        }
        
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
        }
        setupHeight(stackHeight: 70, textFieldHeight: 40, buttonHeight: 40)
    }
    
    private func configureView() {
        backgroundColor = .background
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.registerClassForCell(UITableViewCell.self)
        tableView.rowHeight = 400
        chooseFormTitle.text = "Выберите форму собственности"
        nameUserView.rightTitle.isHidden = false
        nameUserView.rightTitle.text = "Обязательно"
        ipButton.setTitle("ИП", for: .normal)
        tooButton.setTitle("ТОО", for: .normal)
        nameUserView.title.text = "Наименование юридического лица"
        nameUserView.textField.placeholder = "Наименование"
        binUserView.configureTexts(placeHolderText: "БИН", titleText: "БИН")
        cityView.title.text = "Город"
        streetView.configureTexts(placeHolderText: "Улица", titleText: "Улица")
        numberHouseTitle.text = "Номер дома"
        numberOfficeTitle.text = "Номер офиса"
        phoneNumberTitle.text = "Укажите Ваш контактный телефон"
        emailTitle.text = "Укажите вашу почту"
        emailTextField.placeholder = "Почта"
        coordinateTitle.text = "Укажите геопозицию объекта"
        coordinateTextField.placeholder = "Адрес..."
        registerButton.setTitle("Отправить", for: .normal)
        offerView.configureView(titleText: "Ознокомьтесь с публичным договором(Оферта)", offerTitle: "Я согласен(-на) с условиями оферты", image: #imageLiteral(resourceName: "dogovor"))
    }
    
    private func setupHeight(stackHeight: CGFloat, textFieldHeight: CGFloat, buttonHeight: CGFloat) {
        buttonStack.snp.makeConstraints { $0.height.equalTo(buttonHeight)}
        nameUserView.snp.makeConstraints {$0.height.equalTo(stackHeight)}
        nameUserView.textField.snp.makeConstraints { $0.height.equalTo(textFieldHeight)}
        binUserView.snp.makeConstraints { $0.height.equalTo(stackHeight)}
        binUserView.textField.snp.makeConstraints { $0.height.equalTo(textFieldHeight)}
        addressStackView.snp.makeConstraints { $0.height.equalTo(stackHeight)}
        numberHouse.snp.makeConstraints { $0.height.equalTo(textFieldHeight)}
        numberOffice.snp.makeConstraints { $0.height.equalTo(textFieldHeight)}
        numberStackView.snp.makeConstraints { $0.height.equalTo(stackHeight)}
        cityView.cityTextField.snp.makeConstraints { $0.height.equalTo(textFieldHeight)}
        streetView.textField.snp.makeConstraints { $0.height.equalTo(textFieldHeight)}
        phoneView.snp.makeConstraints { $0.height.equalTo(stackHeight)}
        numberPhoneTextField.snp.makeConstraints { $0.height.equalTo(textFieldHeight)}
        emailStack.snp.makeConstraints { $0.height.equalTo(stackHeight)}
        emailTextField.snp.makeConstraints { $0.height.equalTo(textFieldHeight)}
        coordinateView.snp.makeConstraints { $0.height.equalTo(stackHeight)}
        coordinateTextField.snp.makeConstraints { $0.height.equalTo(textFieldHeight)}
        offerView.snp.makeConstraints { $0.height.equalTo(stackHeight)}
        
        registerButton.snp.makeConstraints { $0.height.equalTo(buttonHeight)}
         
//        if addshadow == true {
//            bin
//        }
    }
    
    func buttonActive(ipButtonSelected: Bool) {
        if ipButtonSelected == true {
            ipButton.backgroundColor = .primary
            tooButton.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        } else {
            ipButton.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
            tooButton.backgroundColor = .secondary
        }
    }
    
   @objc func checkBox() {
      isSelected = !isSelected
    }
 
}
