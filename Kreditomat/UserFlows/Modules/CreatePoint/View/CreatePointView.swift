//
//  CreatePointView.swift
//  Kreditomat
//
//  Created by kairzhan on 5/10/21.
//

import UIKit

class CreatePointView: UIView {
    let questionLabel: UILabel = {
        let label = UILabel()
        label.text =  "Вы хотите создать новую точку?"
        label.textColor = .gray
        return label
    }()
    
    let createButton: PrimaryButton = {
        let button = PrimaryButton()
        button.setTitle("СОЗДАТЬ ТОЧКУ", for: .normal)
        return button
    }()
    
    let chooseLabel: UILabel = {
        let label = UILabel()
        label.text =  "Выберите точку"
        label.textColor = .black
        return label
    }()
    
    let pointsList = TextFieldContainer()
    
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
        
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(pointsList.snp.bottom).offset(20)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    private func configureView() {
        backgroundColor = .background
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.registerClassForCell(PointCell.self)
        tableView.rowHeight = 400
        pointsList.textField.placeholder = "Все ..."
        createButton.layer.addShadow()
        pointsList.layer.addShadow()
    }
}
