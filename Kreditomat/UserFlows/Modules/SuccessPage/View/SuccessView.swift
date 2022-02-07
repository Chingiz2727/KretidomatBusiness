//
//  SuccessView.swift
//  Kreditomat
//
//  Created by kairzhan on 5/10/21.
//

import UIKit

class SuccessView: UIView {
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Images.success.image
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Поздравляем!"
        label.font = .bold15
        return label
    }()
    
    let clientTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Вы успешно приняли денежные средства:"
        label.font = .regular14
        label.textAlignment = .center
        return label
    }()
    
    let clientValueLabel: UILabel = {
        let label = UILabel()
        label.text = "Серхио Рамос"
        label.font = .bold15
        label.textAlignment = .center
        return label
    }()
    
    lazy var clientStackView = UIStackView(
        views: [clientTitleLabel, clientValueLabel],
        axis: .vertical,
        distribution: .fillEqually,
        spacing: 1)
    
    let sumTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "на сумму:"
        label.textAlignment = .center
        label.font = .regular14
        
        return label
    }()
    
    let sumValueLabel: UILabel = {
        let label = UILabel()
        label.text = "000  тенге"
        label.textAlignment = .center
        label.font = .bold15
        return label
    }()
    
    lazy var sumStackView = UIStackView(
        views: [sumTitleLabel, sumValueLabel],
        axis: .horizontal,
        distribution: .fillEqually,
        spacing: 0)
    
    let bonusTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Ваш бонус увеличился на:"
        label.font = .regular14
        label.textAlignment = .center
        return label
    }()
    
    let bonusValueLabel: UILabel = {
        let label = UILabel()
        label.text = "000 тенге"
        label.textAlignment = .center
        label.font = .bold15
        return label
    }()
    
    lazy var bonusStackView = UIStackView(
        views: [bonusTitleLabel, bonusValueLabel],
        axis: .vertical,
        distribution: .fillEqually,
        spacing: 0)
    
    let balanceTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Остаток в точке получения/погашения:"
        label.font = .regular14
        label.textAlignment = .center
        return label
    }()
    
    let balanceValueLabel: UILabel = {
        let label = UILabel()
        label.text = "000 тенге"
        label.font = .bold15
        label.textAlignment = .center
        return label
    }()
    
    lazy var balanceStackView = UIStackView(
        views: [balanceTitleLabel, balanceValueLabel],
        axis: .vertical,
        distribution: .fillEqually,
        spacing: 0)
    
    let closeButton = PrimaryButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInitialLayouts()
        configureView()
    }
    
    func setData(data: qrResult, checkoutData: CheckoutData) {
        clientValueLabel.text = "\(data.FIO) ИИН: \(data.IIN)"
        sumValueLabel.text = "\(data.CreditSum) тенге"
        bonusValueLabel.text = "\(checkoutData.BonusSum)"
        balanceValueLabel.text = "\(checkoutData.Balance)"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupInitialLayouts() {
        addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaLayoutGuide).inset(130)
            make.height.width.equalTo(100)
            make.centerX.equalToSuperview()
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        addSubview(clientStackView)
        clientStackView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        addSubview(sumStackView)
        sumStackView.snp.makeConstraints { (make) in
            make.top.equalTo(clientStackView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        addSubview(bonusStackView)
        bonusStackView.snp.makeConstraints { (make) in
            make.top.equalTo(sumStackView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        addSubview(balanceStackView)
        balanceStackView.snp.makeConstraints { (make) in
            make.top.equalTo(bonusStackView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        addSubview(closeButton)
        closeButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(safeAreaLayoutGuide).inset(40)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }
    }
    
    private func configureView() {
        backgroundColor = .background
        closeButton.setTitle("Закрыть", for: .normal)
    }
}
