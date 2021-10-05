//
//  CashierCell.swift
//  Kreditomat
//
//  Created by kairzhan on 5/24/21.
//

import UIKit

class CashierCell: UITableViewCell {
    let containerView = UIView()
    let headerView = UIView()
    let bodyView = UIView()
    var blockCashierCallBack: Callback?
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Наименованиие кассира"
        label.font = .regular14
        label.textColor = .white
        return label
    }()
    
    let cashierItem = InfoItemView()
    let phoneItem = InfoItemView()
    let attachButton = PrimaryButton()
    
    let bodyLockImage: UIButton = {
        let imageView = UIButton()
        imageView.setImage(UIImage(named: "lockOpen"), for: .normal)
        return imageView
    }()
    let backView = UIView()
    let dividerLine = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupInitialLayouts()
        configureView()
    }
    
    private func setupInitialLayouts() {
        contentView.addSubview(backView)
        backView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(20)
            make.left.right.bottom.equalToSuperview()
        }
        
        backView.addSubview(containerView)
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
        
        containerView.addSubview(bodyView)
        bodyView.snp.makeConstraints { (make) in
            make.top.equalTo(headerView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        
        bodyView.addSubview(cashierItem)
        cashierItem.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview().inset(6)
            make.right.equalToSuperview().inset(40)
        }
        
        bodyView.addSubview(bodyLockImage)
        bodyLockImage.snp.makeConstraints { (make) in
            make.right.equalToSuperview().inset(16)
            make.top.equalTo(cashierItem.snp.bottom).offset(12)
            make.size.equalTo(24)
        }
        
        bodyView.addSubview(phoneItem)
        phoneItem.snp.makeConstraints { (make) in
            make.top.equalTo(cashierItem.snp.bottom).offset(20)
            make.left.equalToSuperview().inset(6)
            make.right.equalToSuperview().inset(40)
        }
        
        bodyView.addSubview(dividerLine)
        dividerLine.snp.makeConstraints { (make) in
            make.top.equalTo(phoneItem.snp.bottom).offset(24)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(1)
        }
        
        bodyView.addSubview(attachButton)
        attachButton.snp.makeConstraints { (make) in
            make.top.equalTo(phoneItem.snp.bottom).offset(35)
            make.left.right.equalToSuperview().inset(40)
            make.height.equalTo(40)
        }
    }
    
    private func configureView() {
        backView.layer.cornerRadius = 8
        containerView.layer.cornerRadius = 8
        headerView.layer.cornerRadius = 8
        containerView.layer.borderWidth = 2
        containerView.layer.borderColor = UIColor.primary.cgColor
        headerView.backgroundColor = .primary
        headerView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        bodyView.backgroundColor = .white
        attachButton.setTitle("ПРИКРЕПИТЬ КАССИРА", for: .normal)
        attachButton.layer.addShadow()
        cashierItem.dividerLine.isHidden = true
        phoneItem.dividerLine.isHidden = true
        dividerLine.backgroundColor = .lightGray
    }
    
    func setupData(data: CashierData) {
        cashierItem.setupData(title: "Кассир:", value: data.Name)
        phoneItem.setupData(title: "Телефон:", value: data.Phone)
        bodyLockImage.addTarget(self, action: #selector(blockCashier), for: .touchUpInside)
    }
    
    @objc func blockCashier() {
        blockCashierCallBack?()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
