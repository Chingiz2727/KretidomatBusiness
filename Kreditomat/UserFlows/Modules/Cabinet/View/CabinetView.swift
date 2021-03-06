//
//  CabinetView.swift
//  Kreditomat
//
//  Created by kairzhan on 5/9/21.
//

import UIKit

class CabinetView: UIView {
    
    let profileImageView = UIView()
    
    let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 6
        imageView.contentMode = .scaleToFill
        imageView.image = #imageLiteral(resourceName: "profile")
        return imageView
    }()
    
    let addImageButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(Images.addProfileImage.image, for: .normal)
        return button
    }()
    
    let infoView = UIView()
    
    let agentItem = InfoItemView()
    let binItem = InfoItemView()
    let cityItem = InfoItemView()
    let streetItem = InfoItemView()
    let homeItem = InfoItemView()
    let officeItem = InfoItemView()
    let phoneItem = InfoItemView()
    let emailItem = InfoItemView()
    
    lazy var infoStackView = UIStackView(
        views: [agentItem, binItem, cityItem, streetItem, homeItem, officeItem, phoneItem, emailItem],
        axis: .vertical,
        distribution: .fillEqually,
        spacing: 2)
    
    let bonusSum = SumView()
    let cashboxSum = SumView()
    
    lazy var sumStackView = UIStackView(
        views: [bonusSum, cashboxSum],
        axis: .horizontal,
        distribution: .fillEqually,
        spacing: 12)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInitialLayouts()
        configureView()
        setupData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupInitialLayouts() {
        addSubview(profileImageView)
        profileImageView.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaLayoutGuide).inset(24)
            make.centerX.equalToSuperview()
            make.width.equalTo(87)
            make.height.equalTo(85)
        }
        
        profileImageView.addSubview(profileImage)
        profileImage.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(2)
        }
        
        profileImageView.addSubview(addImageButton)
        addImageButton.snp.makeConstraints { (make) in
            make.right.bottom.equalToSuperview().inset(10)
        }
        
        addSubview(infoView)
        infoView.snp.makeConstraints { (make) in
            make.top.equalTo(profileImageView.snp.bottom).offset(28)
            make.left.right.equalToSuperview().inset(12)
            make.height.equalTo(270)
        }
        
        infoView.addSubview(infoStackView)
        infoStackView.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview().inset(10)
            make.left.right.equalToSuperview()
        }
        
        addSubview(sumStackView)
        sumStackView.snp.makeConstraints { (make) in
            make.top.equalTo(infoView.snp.bottom).offset(28)
            make.left.right.equalToSuperview().inset(10)
            make.height.equalTo(83)
        }
    }
    
    private func configureView() {
        backgroundColor = .background
        profileImageView.layer.cornerRadius = 6
        profileImageView.backgroundColor = .white
        profileImageView.layer.borderColor = UIColor.primary.cgColor
        profileImageView.layer.borderWidth = 2
        profileImageView.layer.addShadow()
        infoView.backgroundColor = .white
        infoView.layer.cornerRadius = 6
        infoView.layer.borderColor = UIColor.secondary.cgColor
        infoView.layer.borderWidth = 2
        infoView.layer.addShadow()
        emailItem.dividerLine.isHidden = true
        bonusSum.layer.addShadow()
        cashboxSum.layer.addShadow()
    }
    
    func setupData() {
        let data = UserInfoStorage.shared
        let type = Role.init(rawValue: data.Role ?? "")
        switch type {
        case .agent:
            agentItem.setupData(title: "??????????:", value: data.Name ?? "")
            phoneItem.setupData(title: "??????????????:", value: data.Phone ?? "")
        case .cashier:
            agentItem.setupData(title: "????????????:", value: data.Name ?? "")
            phoneItem.setupData(title: "??????????????", value: data.CashierPhone ?? "")
        case .none:
            break
        }
        binItem.setupData(title: "??????:", value: data.BIN ?? "")
        cityItem.setupData(title: "??????????:", value: data.City ?? "")
        streetItem.setupData(title: "??????????:", value: data.Address ?? "")
        homeItem.setupData(title: "?????????? ????????:", value: data.House ?? "")
        officeItem.setupData(title: "?????????? ??????????:", value: data.Apartments ?? "")
        emailItem.setupData(title: "??????????:", value: data.Email ?? "")
        bonusSum.setupSum(title: "?????????? ??????????????", value: "\(data.BonusSum ?? 0) ??????????")
        cashboxSum.setupSum(title: "?????????? ?? ??????????", value: "\(data.Balance ?? 0) ??????????")
    }
}
