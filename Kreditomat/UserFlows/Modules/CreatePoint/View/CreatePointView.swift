//
//  CreatePointView.swift
//  Kreditomat
//
//  Created by kairzhan on 5/10/21.
//

import UIKit
import RxSwift

class CreatePointView: UIView {
    var attachSubject = PublishSubject<Void>()
    var points: [Point] = []
    var blockPointCallback: ((Point)->Void)?
    var blockCashierCallback: ((Point) -> Void)?
    let questionLabel: UILabel = {
        let label = UILabel()
        label.text =  "Вы хотите создать новую точку?"
        label.textColor = .gray
        label.font = .regular14
        return label
    }()
    
    let createButton: PrimaryButton = {
        let button = PrimaryButton()
        button.setTitle("СОЗДАТЬ ТОЧКУ", for: .normal)
        return button
    }()
    
    let chooseLabel: UILabel = {
        let label = UILabel()
        label.text =  "Выберите точку"
        label.font = .regular14
        label.textColor = .black
        return label
    }()
    
    let pointsList = TextFieldContainer()
    
    let tableView = UITableView()
    
    let pointImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Images.arrowbottom.image
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInitialLayouts()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupInitialLayouts() {
        addSubview(questionLabel)
        questionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaLayoutGuide).inset(40)
            make.centerX.equalToSuperview()
        }
        
        addSubview(createButton)
        createButton.snp.makeConstraints { (make) in
            make.top.equalTo(questionLabel.snp.bottom).offset(5)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }
        
        addSubview(chooseLabel)
        chooseLabel.snp.makeConstraints { (make) in
            make.top.equalTo(createButton.snp.bottom).offset(20)
            make.left.equalToSuperview().inset(20)
        }
        
        addSubview(pointsList)
        pointsList.snp.makeConstraints { (make) in
            make.top.equalTo(chooseLabel.snp.bottom).offset(5)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }
        
        pointsList.addSubview(pointImage)
        pointImage.snp.makeConstraints { (make) in
            make.right.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
            make.height.equalTo(8)
            make.width.equalTo(14)
        }
        
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(pointsList.snp.bottom).offset(20)
            make.left.right.bottom.equalToSuperview().inset(16)
        }
    }
    
    private func configureView() {
        backgroundColor = .background
        tableView.backgroundColor = .background
        tableView.separatorStyle = .none
        tableView.register(PointCell.self, forCellReuseIdentifier: "point")
        tableView.rowHeight = 210
        pointsList.textField.placeholder = "Выберите точку"
        tableView.showsVerticalScrollIndicator = false
        createButton.layer.addShadow()
        tableView.delegate = self
        tableView.dataSource = self
        pointsList.layer.addShadow()
    }
}

extension CreatePointView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return points.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "point", for: indexPath) as! PointCell
        cell.selectionStyle = .none
        let point = points[indexPath.row]
        cell.setupData(data: point)
        cell.blockPointCallBack = { [weak self] in
            self?.blockPointCallback?(point)
        }
        
        cell.blockCashierCallBack = { [weak self] in
            self?.blockCashierCallback?(point)
        }
        cell.attachButton.addTarget(self, action: #selector(attach), for: .touchUpInside)
        cell.layer.addShadow()
        return cell
    }
    
    @objc func attach() {
        attachSubject.onNext(())
    }
}
