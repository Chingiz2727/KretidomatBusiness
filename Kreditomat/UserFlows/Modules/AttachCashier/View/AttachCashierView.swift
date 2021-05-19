//
//  AttachCashierView.swift
//  Kreditomat
//
//  Created by kairzhan on 5/11/21.
//

import UIKit

class AttachCashierView: UIView {
    let chooseLabel: UILabel = {
        let label = UILabel()
        label.text = "Выберите точку"
        label.font = .regular14
        label.textColor = .black
        return label
    }()
    
    let pointsList = TextFieldContainer()
    
    let pointImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Images.arrowbottom.image
        return imageView
    }()
    
    let nameCashierLabel: UILabel = {
        let label = UILabel()
        label.text =  "Введите ФИО кассира"
        label.font = .regular14
        label.textColor = .black
        return label
    }()
    
    let nameCashierTextField = TextFieldContainer()
    
    let phoneCashierLabel: UILabel = {
        let label = UILabel()
        label.text =  "Введите номер телефона кассира"
        label.font = .regular14
        label.textColor = .black
        return label
    }()
    
    let phoneCashierTextField = PhoneNumberTextField()
    
    let attachButton = PrimaryButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInitialLayouts()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupInitialLayouts() {
        addSubview(chooseLabel)
        chooseLabel.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaLayoutGuide).inset(40)
            make.left.equalToSuperview().inset(20)
        }
        
        addSubview(pointsList)
        pointsList.snp.makeConstraints { (make) in
            make.top.equalTo(chooseLabel.snp.bottom).offset(5)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }
        
        pointsList.addSubview(pointImage)
        pointImage.snp.makeConstraints { (make) in
            make.right.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
            make.height.equalTo(8)
            make.width.equalTo(14)
        }
        
        addSubview(nameCashierLabel)
        nameCashierLabel.snp.makeConstraints { (make) in
            make.top.equalTo(pointsList.snp.bottom).offset(10)
            make.left.equalToSuperview().inset(20)
        }
        
        addSubview(nameCashierTextField)
        nameCashierTextField.snp.makeConstraints { (make) in
            make.top.equalTo(nameCashierLabel.snp.bottom).offset(5)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }
        
        addSubview(phoneCashierLabel)
        phoneCashierLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameCashierTextField.snp.bottom).offset(10)
            make.left.equalToSuperview().inset(20)
        }
        
        addSubview(phoneCashierTextField)
        phoneCashierTextField.snp.makeConstraints { (make) in
            make.top.equalTo(phoneCashierLabel.snp.bottom).offset(5)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }
        
        addSubview(attachButton)
        attachButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(safeAreaLayoutGuide).inset(40)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }
    }
    
    private func configureView() {
        backgroundColor = .background
        pointsList.textField.placeholder = "Все ..."
        nameCashierTextField.textField.placeholder = "ФИО кассира"
        attachButton.setTitle("ПРИКРЕПИТЬ КАССИРА", for: .normal)
        pointsList.layer.addShadow()
        nameCashierTextField.layer.addShadow()
        phoneCashierTextField.layer.addShadow()
    }
}
