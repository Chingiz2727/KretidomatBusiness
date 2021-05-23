import UIKit
import InputMask
import RxSwift

final class RegisterView: UIView {
    
    private let scrollView = UIScrollView()
    let tableView = UITableView()
    var isSelected : Bool = false {
        didSet {
            if isSelected == true {
                offerView.checkBox.setImage(Images.checkboxSelected.image, for: .normal)
//                registerButton.backgroundColor = .primary
//                registerButton.isEnabled = true
            } else {
                offerView.checkBox.setImage(Images.checkboxUnselected.image, for: .normal)
//                registerButton.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
//                registerButton.isEnabled = false
            }
        }
    }
    
    let selectedSubject = PublishSubject<Bool>()
    
    let chooseFormTitle: UILabel = {
        let label = UILabel()
        label.text = "Выберите форму собственности"
        label.font = .regular12
        label.textAlignment = .center
        label.textColor = UIColor.gray.withAlphaComponent(0.7)
        return label
    }()
    
    let ipButton: UIButton = {
        let button = UIButton()
        button.setTitle("ИП", for: .normal)
        button.layer.cornerRadius = 20
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .primary
        return button
    }()
    
    let tooButton: UIButton = {
        let button = UIButton()
        button.setTitle("ТОО", for: .normal)
        
        button.layer.cornerRadius = 20
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .secondary
        return button
    }()
    
    let cityView = CityContainerView()
    
    let numberHouseView = UIView()
    let numberOfficeView = UIView()
    let numberHouseTitle: UILabel = {
        let l = UILabel()
        l.text = "Номер дома"
        l.font = .regular12
        l.textAlignment = .left
        return l
    }()
    
    let numberOfficeTitle: UILabel = {
        let l = UILabel()
        l.text = "Номер офиса"
        l.font = .regular12
        l.textAlignment = .left
        return l
    }()
    
    let numberHouse: NumberTextField = {
        let tf = NumberTextField()
        tf.currentState = .error
        tf.placeholder = "000"
        return tf
    }()
    
    let numberOffice: NumberTextField = {
        let tf = NumberTextField()
        tf.currentState = .error
        tf.placeholder = "000"
        return tf
    }()
    
    let nameUserView = TitleAndTextField()
    let binUserView = TitleAndTextField()
    let streetView = TitleAndTextField()
    
    let phoneView = UIView()
    let phoneNumberTitle: UILabel = {
        let l = UILabel()
        l.text = "Укажите Ваш контактный телефон"
        l.font = .regular12
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
        l.text = "Укажите вашу почту"
        l.font = .regular12
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
        l.text = "Укажите геопозицию объекта"
        l.font = .regular12
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
        b.layer.cornerRadius = 10
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
    
    let registerButton: PrimaryButton = {
        let button = PrimaryButton()
        button.setTitle("Отправить", for: .normal)
        button.layer.cornerRadius = 20
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    lazy var buttonStack = UIStackView(views: [ipButton, tooButton], axis: .horizontal, distribution: .fillEqually, spacing: 10)
    
    lazy var addressStackView = UIStackView(views: [cityView, streetView], axis: .horizontal, distribution: .fillEqually, spacing: 5)
    
    lazy var numberStackView = UIStackView(views: [numberHouseView, numberOfficeView], axis: .horizontal, distribution: .fillEqually, spacing: 5)
    
    lazy var fullStackView = UIStackView(views: [chooseFormTitle, buttonStack, nameUserView, binUserView, addressStackView, numberStackView, phoneView, emailView, coordinateView, offerView, registerButton], axis: .vertical, distribution: .fill, spacing: 5)
    
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
            make.top.equalToSuperview().inset(20)
            make.leading.trailing.width.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(30)
        }
        
        numberHouseView.snp.makeConstraints { $0.height.equalTo(60)}
        numberOfficeView.snp.makeConstraints { $0.height.equalTo(60)}
        numberHouseView.addSubview(numberHouseTitle)
        numberHouseView.addSubview(numberHouse)
        
        numberHouseTitle.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(10)
        }
        
        numberHouse.snp.makeConstraints { make in
            make.top.equalTo(numberHouseTitle.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview()
        }
        
        numberOfficeView.addSubview(numberOfficeTitle)
        numberOfficeView.addSubview(numberOffice)
        
        numberOfficeTitle.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(10)
        }
        
        numberOffice.snp.makeConstraints { make in
            make.top.equalTo(numberOfficeTitle.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview()
        }
        
        phoneView.addSubview(phoneNumberTitle)
        phoneNumberTitle.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(10)
        }
        
        phoneView.addSubview(numberPhoneTextField)
        numberPhoneTextField.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberTitle.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview()
        }
        
        emailView.addSubview(emailTitle)
        emailView.addSubview(emailTextField)
        
        emailTitle.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview().inset(10)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTitle.snp.bottom).offset(5)
            make.left.right.equalToSuperview()
        }
        
        coordinateView.addSubview(coordinateTitle)
        coordinateTitle.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(10)
        }
        
        coordinateView.addSubview(coordinateTextField)
        coordinateTextField.snp.makeConstraints { make in
            make.top.equalTo(coordinateTitle.snp.bottom).offset(5)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview().inset(70)
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
        
        offerView.snp.makeConstraints { $0.height.equalTo(100)}
        
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
        nameUserView.rightTitle.isHidden = false
        nameUserView.textField.currentState = .error
        nameUserView.rightTitle.text = "Обязательно"
        nameUserView.title.text = "Наименование юридического лица"
        nameUserView.textField.placeholder = "Наименование"
        binUserView.configureTexts(placeHolderText: "БИН", titleText: "БИН")
        binUserView.textField.currentState = .error
        binUserView.textField.format = "[0…]"
        binUserView.textField.keyboardType = .numberPad
        cityView.title.text = "Город"
        cityView.cityListTextField.textField.currentState = .error
        cityView.cityListTextField.textField.placeholder = "Город"
        streetView.configureTexts(placeHolderText: "Улица", titleText: "Улица")
        streetView.textField.currentState = .error
        emailTextField.placeholder = "Почта"
        coordinateTextField.placeholder = "Адрес..."
        offerView.configureView(titleText: "Ознакомьтесь с публичным договором(Оферта)", offerTitle: "Я согласен(-на) с условиями оферты", image: #imageLiteral(resourceName: "dogovor"))
        configureShadows()
    }
    
    private func configureShadows() {
        ipButton.layer.addShadow()
        tooButton.layer.addShadow()
        nameUserView.textField.layer.addShadow()
        binUserView.textField.layer.addShadow()
        cityView.cityListTextField.layer.addShadow()
        streetView.textField.layer.addShadow()
        numberHouse.layer.addShadow()
        numberOffice.layer.addShadow()
        numberPhoneTextField.layer.addShadow()
        emailTextField.layer.addShadow()
        coordinateTextField.layer.addShadow()
        coordinateButtonView.layer.addShadow()
        offerView.checkBox.layer.addShadow()
        offerView.buttonContainerView.layer.addShadow()
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
        cityView.snp.makeConstraints { $0.height.equalTo(stackHeight)}
        cityView.cityListTextField.snp.makeConstraints { $0.height.equalTo(textFieldHeight)}
        streetView.textField.snp.makeConstraints { $0.height.equalTo(textFieldHeight)}
        phoneView.snp.makeConstraints { $0.height.equalTo(stackHeight)}
        numberPhoneTextField.snp.makeConstraints { $0.height.equalTo(textFieldHeight)}
        emailView.snp.makeConstraints { $0.height.equalTo(stackHeight)}
        emailTextField.snp.makeConstraints { $0.height.equalTo(textFieldHeight)}
        coordinateView.snp.makeConstraints { $0.height.equalTo(stackHeight)}
        coordinateTextField.snp.makeConstraints { $0.height.equalTo(textFieldHeight)}
        registerButton.snp.makeConstraints { $0.height.equalTo(buttonHeight)}
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
      selectedSubject.onNext(isSelected)
    isSelected = !isSelected
    }
    
}
