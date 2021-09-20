//
//  MapView.swift
//  Kreditomat
//
//  Created by kairzhan on 5/20/21.
//

import UIKit
import YandexMapsMobile
import SnapKit

class MapView: UIView {
    let mapView = YMKMapView()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Images.placeholder.image
        return imageView
    }()
    
    let myLocationButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(Images.lock.image, for: .normal)
        return button
    }()
    
    let locationButton = UIButton()
    let textField = RegularTextField()
    let saveButton = PrimaryButton()
    let tableView = UITableView()
    private var contentSizeObserver: NSKeyValueObservation?
    private var heightConstraint: Constraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentSizeObserver = tableView.observe(
            \.contentSize,
            options: [.initial, .new]
        ) { [weak self] tableView, _ in
            self?.heightConstraint?.update(offset: max(40, tableView.contentSize.height))
        }
        
        setupInitialLayouts()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupInitialLayouts() {
        addSubview(mapView)
        mapView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        mapView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
            make.size.equalTo(40)
        }
        
        addSubview(textField)
        addSubview(saveButton)
        addSubview(tableView)
        addSubview(locationButton)
        //addSubview(myLocationButton)
        
//        myLocationButton.snp.makeConstraints { (make) in
//            make.right.equalToSuperview().inset(20)
//            make.bottom.equalToSuperview().inset(120)
//        }
        
        locationButton.snp.makeConstraints { make in
            make.size.equalTo(40)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(20)
        }
        
        locationButton.setImage(#imageLiteral(resourceName: "compass").withRenderingMode(.alwaysTemplate), for: .normal)
        locationButton.imageView?.tintColor = .white
        locationButton.layer.cornerRadius = 20
        locationButton.backgroundColor = .primary
        tableView.snp.makeConstraints  { make in
            make.top.equalTo(textField.snp.bottom)
            make.leading.trailing.equalTo(textField)
            heightConstraint = make.height.equalTo(0).constraint
        }
        
        textField.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).inset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
        saveButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide).inset(30)
            make.leading.trailing.equalToSuperview().inset(80)
            make.height.equalTo(40)
        }
    }
    
    private func configureView() {
        textField.clearButtonMode = .always
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.setTitle("Подтвердить", for: .normal)
        tableView.registerClassForCell(UITableViewCell.self)
        tableView.tableHeaderView = nil
        tableView.tableFooterView = nil
        tableView.isHidden = true
        tableView.estimatedRowHeight = 40
        tableView.rowHeight = 40
    }
}
