//
//  SumView.swift
//  Kreditomat
//
//  Created by kairzhan on 5/9/21.
//

import UIKit

class SumView: UIView {
    let containerView = UIView()
    
    let titleView = UIView()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .regular12
        return label
    }()
    
    let valueView = UIView()
    
    let valueTitle: UILabel = {
        let label = UILabel()
        label.text = "000 тенге"
        label.textColor = .gray
        label.font = .regular12
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInitialLayouts()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSum(title: String, value: String) {
        titleLabel.text = title
        valueTitle.text = value
    }
    
    private func setupInitialLayouts() {
        addSubview(containerView)
        containerView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        containerView.addSubview(titleView)
        titleView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(28)
        }
        
        titleView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
        }
        
        containerView.addSubview(valueView)
        valueView.snp.makeConstraints { (make) in
            make.top.equalTo(titleView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        
        valueView.addSubview(valueTitle)
        valueTitle.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    private func configureView() {
        containerView.layer.cornerRadius = 6
        containerView.layer.borderWidth = 2
        containerView.layer.borderColor = UIColor.secondary.cgColor
        titleView.backgroundColor = .secondary
        titleView.layer.cornerRadius = 6
        valueView.layer.cornerRadius = 6
        valueView.backgroundColor = .white
        titleView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        valueView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
}
