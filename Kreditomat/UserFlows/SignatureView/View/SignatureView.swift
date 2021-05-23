//
//  SignatureViewe.swift
//  Kreditomat
//
//  Created by Чингиз Куандык on 11.05.2021.
//

import Foundation
import UIKit
import TouchDraw

final class SignatureView: UIView {
 
    let drawerView: TouchDrawView = {
        let view = TouchDrawView()
        view.isUserInteractionEnabled = true
        view.setColor(.black)
        view.setWidth(2)
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.primary.cgColor
        view.backgroundColor = .white
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .regular14
        label.textAlignment = .center
        label.text = "Ставя подпись. Вы соглашаетесь со всеми \nусловиями договора(Офферта)"
        label.textColor = .lightGray
        return label
    }()
    
    let repeatButton = PrimaryButton()
    let confirmButton = PrimaryButton()
    
    private lazy var buttonStack = UIStackView(
        views: [repeatButton, confirmButton],
        axis: .horizontal,
        distribution: .fillEqually,
        alignment: .center,
        spacing: 10)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInitialLayout()
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    private func setupInitialLayout() {
        addSubview(titleLabel)
        addSubview(drawerView)
        addSubview(buttonStack)
        
        buttonStack.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide).inset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(safeAreaLayoutGuide).inset(20)
        }
        
        drawerView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(40)
            make.height.equalTo(drawerView.snp.width)
        }
        
        repeatButton.setTitle("Повторить", for: .normal)
        confirmButton.setTitle("Подтвердить", for: .normal)
        repeatButton.snp.makeConstraints { $0.height.equalTo(44) }
        confirmButton.snp.makeConstraints { $0.height.equalTo(44) }

        backgroundColor = .background
    }
}
