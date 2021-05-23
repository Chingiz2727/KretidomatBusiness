//
//  CreatePointFormView.swift
//  Kreditomat
//
//  Created by kairzhan on 5/12/21.
//

import UIKit

class CreatePointFormView: UIView {
    let scrollView = UIScrollView()
    let pointNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Введите наименование точки"
        label.font = .regular14
        label.textColor = .black
        return label
    }()
    
    let pointNameTextField = TextFieldContainer()
    
    let cityNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Город"
        label.textColor = .black
        label.font = .regular14
        return label
    }()
    
    let cityList = TextFieldContainer()
    
    let cityImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Images.arrowbottom.image
        return imageView
    }()
    
    lazy var cityStackView = UIStackView(
        views: [cityNameLabel, cityList],
        axis: .vertical,
        distribution: .equalSpacing,
        spacing: 5)
    
    let streetNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Улица"
        label.textColor = .black
        label.font = .regular14
        return label
    }()
    
    let streetList = TextFieldContainer()
    
    lazy var streetStackView = UIStackView(
        views: [streetNameLabel, streetList],
        axis: .vertical,
        distribution: .equalSpacing,
        spacing: 5)
    
    lazy var addressStackView = UIStackView(
        views: [cityStackView, streetStackView],
        axis: .horizontal,
        distribution: .fillEqually,
        spacing: 10)
    
    let houseNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "Номер дома"
        label.font = .regular14
        label.textColor = .black
        return label
    }()
    
    let houseNumberTextField = NumberTextFieldContainer()
    
    lazy var houseStackView = UIStackView(
        views: [houseNumberLabel, houseNumberTextField],
        axis: .vertical,
        distribution: .equalSpacing,
        spacing: 5)
    
    let officeNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "Номер офиса"
        label.font = .regular14
        label.textColor = .black
        return label
    }()
    
    let officeNumberTextField = NumberTextFieldContainer()
    
    lazy var officeStackView = UIStackView(
        views: [officeNumberLabel, officeNumberTextField],
        axis: .vertical,
        distribution: .equalSpacing,
        spacing: 5)
    
    lazy var numberStackView = UIStackView(
        views: [houseStackView, officeStackView],
        axis: .horizontal,
        distribution: .fillEqually,
        spacing: 10)
    
    let operatingModeLabel: UILabel = {
        let label = UILabel()
        label.text = "Укажите режим работы точки"
        label.font = .regular14
        label.textColor = .black
        return label
    }()
    
    let startDayTextField = TextFieldContainer()
    let endDayTextField = TextFieldContainer()
    let dayHyphen: UILabel = {
        let label = UILabel()
        label.text = "-"
        label.textColor = .black
        return label
    }()
    
    lazy var dayStackView = UIStackView(
        views: [startDayTextField, dayHyphen, endDayTextField],
        axis: .horizontal,
        distribution: .fillProportionally,
        spacing: 2)
    
    let startTimeTextField = TimeTextFieldContainer()
    let endTimeTextField = TimeTextFieldContainer()
    let timeHyphen: UILabel = {
        let label = UILabel()
        label.text = "-"
        label.textColor = .black
        return label
    }()
    
    lazy var timeStackView = UIStackView(
        views: [startTimeTextField, timeHyphen, endTimeTextField],
        axis: .horizontal,
        distribution: .fill,
        spacing: 2)
    
    let startImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Images.arrowbottom.image
        return imageView
    }()
    
    let endImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Images.arrowbottom.image
        return imageView
    }()
    
    let cashierNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Введите ФИО кассира"
        label.font = .regular14
        label.textColor = .black
        return label
    }()
    
    let cashierNameTextField = TextFieldContainer()
    
    let phoneLCashierabel: UILabel = {
        let label = UILabel()
        label.text = "Введите номер телефона кассира"
        label.font = .regular14
        label.textColor = .black
        return label
    }()
    
    let phoneCashierTextField = PhoneNumberTextField()
    
    let createButton = PrimaryButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInitialLayouts()
        configureView()
        scrollView.alwaysBounceVertical = true
        scrollView.bounces = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupInitialLayouts() {
        addSubview(scrollView)
        scrollView.snp.makeConstraints { $0.edges.height.equalToSuperview()
        }
        
        scrollView.addSubview(pointNameLabel)
        pointNameLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(20)
            make.left.equalTo(self).inset(20)
        }
        
        scrollView.addSubview(pointNameTextField)
        pointNameTextField.snp.makeConstraints { (make) in
            make.top.equalTo(pointNameLabel.snp.bottom).offset(5)
            make.left.right.equalTo(self).inset(16)
            make.height.equalTo(40)
        }
        
        scrollView.addSubview(addressStackView)
        addressStackView.snp.makeConstraints { (make) in
            make.top.equalTo(pointNameTextField.snp.bottom).offset(10)
            make.left.right.equalTo(self).inset(16)
        }
        
        cityList.snp.makeConstraints { (make) in
            make.height.equalTo(40)
        }

        cityList.addSubview(cityImage)
        cityImage.snp.makeConstraints { (make) in
            make.right.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
            make.height.equalTo(8)
            make.width.equalTo(14)
        }

        streetList.snp.makeConstraints { (make) in
            make.height.equalTo(40)
        }
        
        scrollView.addSubview(numberStackView)
        numberStackView.snp.makeConstraints { (make) in
            make.top.equalTo(addressStackView.snp.bottom).offset(10)
            make.left.right.equalTo(self).inset(16)
        }
        
        houseNumberTextField.snp.makeConstraints { (make) in
            make.height.equalTo(40)
        }
        
        officeNumberTextField.snp.makeConstraints { (make) in
            make.height.equalTo(40)
        }
        
        scrollView.addSubview(operatingModeLabel)
        operatingModeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(numberStackView.snp.bottom).offset(30)
            make.centerX.equalTo(self)
        }
        
        scrollView.addSubview(dayStackView)
        dayStackView.snp.makeConstraints { (make) in
            make.top.equalTo(operatingModeLabel.snp.bottom).offset(5)
            make.centerX.equalTo(self)
        }
        
        startDayTextField.snp.makeConstraints { (make) in
            make.height.equalTo(40)
            make.width.equalTo(80)
        }
        
        startDayTextField.addSubview(startImage)
        startImage.snp.makeConstraints { (make) in
            make.right.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
            make.height.equalTo(8)
            make.width.equalTo(14)
        }
        
        endDayTextField.snp.makeConstraints { (make) in
            make.height.equalTo(40)
            make.width.equalTo(80)
        }
        
        endDayTextField.addSubview(endImage)
        endImage.snp.makeConstraints { (make) in
            make.right.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
            make.height.equalTo(8)
            make.width.equalTo(14)
        }
        
        scrollView.addSubview(timeStackView)
        timeStackView.snp.makeConstraints { (make) in
            make.top.equalTo(dayStackView.snp.bottom).offset(10)
            make.centerX.equalTo(self)
        }
        
        startTimeTextField.snp.makeConstraints { (make) in
            make.height.equalTo(40)
            make.width.equalTo(80)
        }
        
        endTimeTextField.snp.makeConstraints { (make) in
            make.height.equalTo(40)
            make.width.equalTo(80)
        }
        
        scrollView.addSubview(phoneLCashierabel)
        phoneLCashierabel.snp.makeConstraints { (make) in
            make.top.equalTo(timeStackView.snp.bottom).offset(30)
            make.left.equalTo(self).inset(20)
        }
        
        scrollView.addSubview(phoneCashierTextField)
        phoneCashierTextField.snp.makeConstraints { (make) in
            make.top.equalTo(phoneLCashierabel.snp.bottom).offset(5)
            make.left.right.equalTo(self).inset(16)
            make.height.equalTo(40)
        }
        
        scrollView.addSubview(createButton)
        createButton.snp.makeConstraints { (make) in
            make.top.equalTo(phoneCashierTextField.snp.bottom).offset(50)
            make.left.right.equalTo(self).inset(16)
            make.bottom.equalToSuperview().inset(30)
            make.height.equalTo(40)
        }
    }
    
    private func configureView() {
        backgroundColor = .background
        pointNameTextField.textField.placeholder = "Наименование"
        pointNameTextField.layer.addShadow()
        cityList.textField.placeholder = "Город"
        cityList.layer.addShadow()
        streetList.textField.placeholder = "Улица"
        streetList.layer.addShadow()
        houseNumberTextField.layer.addShadow()
        officeNumberTextField.layer.addShadow()
        startDayTextField.textField.placeholder = "ПН"
        startDayTextField.layer.addShadow()
        endDayTextField.textField.placeholder = "ВС"
        endDayTextField.layer.addShadow()
        startTimeTextField.layer.addShadow()
        endTimeTextField.layer.addShadow()
        cashierNameTextField.textField.placeholder = "ФИО кассира"
        cashierNameTextField.layer.addShadow()
        phoneCashierTextField.layer.addShadow()
        createButton.setTitle("СОЗДАТЬ", for: .normal)
        createButton.layer.addShadow()
        scrollView.clipsToBounds = true
    }
}
