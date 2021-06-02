//
//  CreateCashierView.swift
//  Kreditomat
//
//  Created by kairzhan on 5/24/21.
//

import UIKit

class CreateCashierView: UIView {
    let questionLabel: UILabel = {
        let label = UILabel()
        label.text =  "Вы хотите создать нового кассира?"
        label.textColor = .gray
        label.font = .regular14
        return label
    }()
    
    let createButton: PrimaryButton = {
        let button = PrimaryButton()
        button.setTitle("СОЗДАТЬ КАССИРА", for: .normal)
        return button
    }()
    
    let chooseLabel: UILabel = {
        let label = UILabel()
        label.text =  "Выберите кассира"
        label.font = .regular14
        label.textColor = .black
        return label
    }()
    
    let cashiersList = TextFieldContainer()
    
    let tableView = UITableView()
    
    let pointImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Images.arrowbottom.image
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInitialLayouts()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupInitialLayouts() {
        addSubview(questionLabel)
        questionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaLayoutGuide).inset(40)
            make.centerX.equalToSuperview()
        }
        
        addSubview(createButton)
        createButton.snp.makeConstraints { (make) in
            make.top.equalTo(questionLabel.snp.bottom).offset(5)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }
        
        addSubview(chooseLabel)
        chooseLabel.snp.makeConstraints { (make) in
            make.top.equalTo(createButton.snp.bottom).offset(20)
            make.left.equalToSuperview().inset(20)
        }
        
        addSubview(cashiersList)
        cashiersList.snp.makeConstraints { (make) in
            make.top.equalTo(chooseLabel.snp.bottom).offset(5)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }
        
        cashiersList.addSubview(pointImage)
        pointImage.snp.makeConstraints { (make) in
            make.right.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
            make.height.equalTo(8)
            make.width.equalTo(14)
        }
        
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(cashiersList.snp.bottom).offset(20)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    private func configureView() {
        backgroundColor = .background
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.registerClassForCell(PointCell.self)
        tableView.rowHeight = 400
        cashiersList.textField.placeholder = "Все ..."
        createButton.layer.addShadow()
        cashiersList.layer.addShadow()
        
    }
}
