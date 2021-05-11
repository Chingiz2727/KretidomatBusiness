//
//  CameraView.swift
//  Kreditomat
//
//  Created by kairzhan on 5/11/21.
//

import UIKit

final class CameraView: UIView {
    private let titleLabel = UILabel()
    private let rectangleImageView = UIImageView()
    let contentView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInitialLayout()
        configureView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupInitialLayout() {
        addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(rectangleImageView)
        contentView.snp.makeConstraints { $0.edges.equalToSuperview() }
        titleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(100)
        }

        rectangleImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(300)
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
        }
    }

    private func configureView() {
        titleLabel.text = "Отсканируйте QR код клиента \nдля выдачи микрокредита"
        titleLabel.numberOfLines = 0
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        contentView.backgroundColor = .clear
        backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
    }
}
