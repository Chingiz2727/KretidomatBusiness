//
//  CreateCashierFormView.swift
//  Kreditomat
//
//  Created by kairzhan on 5/24/21.
//

import UIKit

class CreateCashierFormView: UIView {
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
    
    let createButton = PrimaryButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInitialLayouts()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupInitialLayouts() {
        
        addSubview(nameCashierLabel)
        nameCashierLabel.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaLayoutGuide).inset(40)
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
        
        addSubview(createButton)
        createButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(safeAreaLayoutGuide).inset(40)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }
    }
    
    private func configureView() {
        backgroundColor = .background
        nameCashierTextField.textField.placeholder = "ФИО кассира"
        createButton.setTitle("Создать", for: .normal)
        nameCashierTextField.layer.addShadow()
        phoneCashierTextField.layer.addShadow()
    }
}
