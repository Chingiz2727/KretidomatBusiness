//
//  File.swift
//  Kreditomat
//
//  Created by Чингиз Куандык on 11.05.2021.
//

import Foundation
import UIKit

final class NameValueView: UIView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 10)
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()

    private let detailLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 10)
        label.numberOfLines = 1
        return label
    }()

    private lazy var stackView = UIStackView(
        views: [titleLabel, detailLabel],
        axis: .horizontal,
        spacing: 5)

    private lazy var horizontalStackView = UIStackView(
        views: [titleLabel, UIView(), detailLabel],
        axis: .horizontal,
        distribution: .fill,
        spacing: 10)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInitialLayout()
    }

    required init?(coder: NSCoder) {
        nil
    }

    func setup(title: String) {
        titleLabel.text = title
    }

    func setup(detail: String) {
        detailLabel.text = detail
    }

    private func setupInitialLayout() {
        addSubview(horizontalStackView)
        horizontalStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            
        }
    }
}
