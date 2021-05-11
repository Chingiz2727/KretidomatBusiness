//
//  InfoItemView.swift
//  Kreditomat
//
//  Created by kairzhan on 5/9/21.
//

import UIKit

class InfoItemView: UIView {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    let valueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        return label
    }()
    
    let dividerLine = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInitialLayouts()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupData(title: String, value: String) {
        titleLabel.text = title
        valueLabel.text = value
    }
    
    private func setupInitialLayouts() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().inset(10)
        }

        addSubview(valueLabel)
        valueLabel.snp.makeConstraints { (make) in
            make.top.right.equalToSuperview().inset(10)
        }
        
        addSubview(dividerLine)
        dividerLine.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(2)
            make.left.right.equalToSuperview().inset(10)
            make.height.equalTo(1)
        }
    }
    
    private func configureView() {
        dividerLine.backgroundColor = .gray
    }
}