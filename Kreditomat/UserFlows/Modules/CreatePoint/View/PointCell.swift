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
    var blockPointCallBack: Callback?
    var blockCashierCallBack: Callback?
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Наименованиие точки"
        label.font = .regular14
        label.textColor = .white
        return label
    }()
    
    let headerLockImage: UIButton = {
        let imageView = UIButton()
        imageView.setImage(UIImage(named: "whiteZamok"), for: .normal)
        return imageView
    }()
    
    let sumItem = InfoItemView()
    let addressItem = InfoItemView()
    let cashierItem = InfoItemView()
    let phoneItem = InfoItemView()
    let attachButton = PrimaryButton()
    let backView = UIView()
    let dividerLine = UIView()
    
    let bodyLockImage: UIButton = {
        let imageView = UIButton()
        let image = UIImage(named: "whiteZamok")?.withRenderingMode(.alwaysTemplate)
        imageView.setImage(image, for: .normal)
        imageView.imageView?.tintColor = .black
        return imageView
    }()
    
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
        
        headerView.addSubview(headerLockImage)
        headerLockImage.snp.makeConstraints { (make) in
            make.right.equalToSuperview().inset(10)
            make.size.equalTo(24)
            make.centerY.equalToSuperview()
        }
        
        containerView.addSubview(bodyView)
        bodyView.snp.makeConstraints { (make) in
            make.top.equalTo(headerView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        
        bodyView.addSubview(sumItem)
        sumItem.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
        }
        
        bodyView.addSubview(addressItem)
        addressItem.snp.makeConstraints { (make) in
            make.top.equalTo(sumItem.snp.bottom).offset(22)
            make.left.right.equalToSuperview()
        }
        
        bodyView.addSubview(cashierItem)
        cashierItem.snp.makeConstraints { (make) in
            make.top.equalTo(addressItem.snp.bottom).offset(22)
            make.left.equalToSuperview()
            make.right.equalToSuperview().inset(40)
        }
        
        bodyView.addSubview(bodyLockImage)
        bodyLockImage.snp.makeConstraints { (make) in
            make.right.equalToSuperview().inset(10)
            make.size.equalTo(24)
            make.top.equalTo(cashierItem.snp.bottom).offset(12)
        }
        
        bodyView.addSubview(phoneItem)
        phoneItem.snp.makeConstraints { (make) in
            make.top.equalTo(cashierItem.snp.bottom).offset(22)
            make.left.equalToSuperview()
            make.right.equalToSuperview().inset(35)
        }
        
//        bodyView.addSubview(dividerLine)
//        dividerLine.snp.makeConstraints { (make) in
//            make.top.equalTo(phoneItem.snp.bottom).offset(24)
//            make.left.right.equalToSuperview().inset(10)
//            make.height.equalTo(1)
//        }
        
//        bodyView.addSubview(attachButton)
//        attachButton.snp.makeConstraints { (make) in
//            make.top.equalTo(phoneItem.snp.bottom).offset(32)
//            make.left.right.equalToSuperview().inset(35)
//            make.height.equalTo(40)
//        }
    }
    
    private func configureView() {
        contentView.backgroundColor = .background
        backView.layer.cornerRadius = 8
        headerView.layer.cornerRadius = 8
        containerView.layer.cornerRadius = 8
        containerView.layer.borderWidth = 2
        containerView.layer.borderColor = UIColor.primary.cgColor
        containerView.layer.addShadow()
        headerView.backgroundColor = .primary
        headerView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        bodyView.backgroundColor = .white
        attachButton.setTitle("ПРИКРЕПИТЬ КАССИРА", for: .normal)
        attachButton.layer.addShadow()
        cashierItem.dividerLine.isHidden = true
        phoneItem.dividerLine.isHidden = true
        dividerLine.backgroundColor = .lightGray
    }
    
    func setupData(data: Point) {
        sumItem.setupData(title: "Сумма в кассе:", value: "\(data.Balance ?? 0) тенге")
        addressItem.setupData(title: "Адрес:", value: "\(data.Address ?? "Адрес точки")")
        cashierItem.setupData(title: "Кассир:", value: "\(data.CashierName ?? "ФИО кассира")")
        phoneItem.setupData(title: "Телефон:", value: "\(data.CashierPhone ?? "87777777777")")
        headerLockImage.addTarget(self, action: #selector(blockPoint), for: .touchUpInside)
        bodyLockImage.addTarget(self, action: #selector(blockCashier), for: .touchUpInside)
    }
    
    @objc func blockPoint() {
        blockPointCallBack?()
    }
    
    @objc func blockCashier() {
        blockCashierCallBack?()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
