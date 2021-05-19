//
//  MenuHeaderView.swift
//  Kreditomat
//
//  Created by Чингиз Куандык on 11.05.2021.
//

import Foundation
import UIKit

final class MenuHeaderView: UIView {
    
    private let imageView = UIImageView()
    let firstValue = NameValueView()
    let secondValue = NameValueView()
    let thirdValue = NameValueView()
    
    private lazy var stackView = UIStackView(views: [imageView, firstValue, secondValue, thirdValue], axis: .vertical, distribution: .fill, alignment: .fill, spacing: 5)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInitalLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    private func setupInitalLayout() {
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(12)
        }
        
        imageView.snp.makeConstraints { make in
            make.height.equalTo(70)
        }
    }
    
    func setupData(data: CabinetData) {
        firstValue.setup(title: "Мой промокод:")
        secondValue.setup(title: "Агент:")
        thirdValue.setup(title: "Телефон:")
        firstValue.setup(detail: "№ \(data.UniqueCode)")
        secondValue.setup(detail: data.Name)
        thirdValue.setup(detail: data.Phone)
    }
    
    private func configureView() {
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "logo")
    }
}
