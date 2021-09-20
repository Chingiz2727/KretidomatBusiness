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
        setupData()
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
    
    func setupData() {
        let data = UserInfoStorage.shared
        firstValue.setup(title: "Мой промокод:")
        thirdValue.setup(title: "Телефон:")
        let unicode = String(data.UniqueCode ?? 0)
        
        firstValue.setup(detail: "№ \(unicode)")
        secondValue.setup(detail: data.Name ?? "")
        thirdValue.setup(detail: data.Phone ?? "")
        let role = Role.init(rawValue: data.Role ?? "")
        switch role {
        case .agent:
            secondValue.setup(title: "Агент:")
        default:
            secondValue.setup(title: "Кассир:")
        }
    }
    
    private func configureView() {
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "logo")
    }
}
