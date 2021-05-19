//
//  PointCell.swift
//  Kreditomat
//
//  Created by kairzhan on 5/11/21.
//

import UIKit

class PointCell: UITableViewCell {
    let containerView = UIView()
    let headerView = UIView()
    let bodyView = UIView()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Наименованиие точки"
        label.font = .regular14
        label.textColor = .white
        return label
    }()
    
    let headerLockImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Images.lock.image
        return imageView
    }()
    
    let sumItem = InfoItemView()
    let addressItem = InfoItemView()
    let cashierItem = InfoItemView()
    let phoneItem = InfoItemView()
    let attachButton = PrimaryButton()
    
    let bodyLockImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Images.lock.image
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupInitialLayouts()
        configureView()
        setupData()
    }
    
    private func setupInitialLayouts() {
        addSubview(containerView)
        containerView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        containerView.addSubview(headerView)
        headerView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(40)
        }
        
        headerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
        }
        
        headerView.addSubview(headerLockImage)
        headerLockImage.snp.makeConstraints { (make) in
            make.right.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
        }
        
        containerView.addSubview(bodyView)
        bodyView.snp.makeConstraints { (make) in
            make.top.equalTo(headerView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        
        bodyView.addSubview(sumItem)
        sumItem.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(20)
            make.left.right.equalToSuperview().inset(10)
        }
        
        bodyView.addSubview(addressItem)
        addressItem.snp.makeConstraints { (make) in
            make.top.equalTo(sumItem.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(10)
        }
        
        bodyView.addSubview(cashierItem)
        cashierItem.snp.makeConstraints { (make) in
            make.top.equalTo(addressItem.snp.bottom).offset(10)
            make.left.equalToSuperview().inset(10)
            make.right.equalToSuperview().inset(40)
        }
        
        bodyView.addSubview(bodyLockImage)
        bodyLockImage.snp.makeConstraints { (make) in
            make.right.equalToSuperview().inset(10)
            make.top.equalTo(cashierItem.snp.bottom).offset(20)
        }
        
        bodyView.addSubview(phoneItem)
        phoneItem.snp.makeConstraints { (make) in
            make.top.equalTo(cashierItem.snp.bottom).offset(20)
            make.left.equalToSuperview().inset(10)
            make.right.equalToSuperview().inset(40)
        }
        
        bodyView.addSubview(attachButton)
        attachButton.snp.makeConstraints { (make) in
            make.top.equalTo(phoneItem.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(40)
            make.height.equalTo(40)
        }
    }
    
    private func configureView() {
        containerView.layer.cornerRadius = 8
        containerView.layer.borderWidth = 2
        containerView.layer.borderColor = UIColor.primary.cgColor
        containerView.layer.addShadow()
        headerView.backgroundColor = .primary
        headerView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        bodyView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        bodyView.backgroundColor = .white
        attachButton.setTitle("ПРИКРЕПИТЬ КАССИРА", for: .normal)
        attachButton.layer.addShadow()
    }
    
    func setupData() {
        sumItem.setupData(title: "Сумма в кассе:", value: "000 тенге")
        addressItem.setupData(title: "Адрес:", value: "Адрес точки")
        cashierItem.setupData(title: "Кассир:", value: "ФИО кассира")
        phoneItem.setupData(title: "Телефон:", value: "87777777777")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
