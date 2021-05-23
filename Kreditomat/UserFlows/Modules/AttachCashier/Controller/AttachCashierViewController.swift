//
//  AttachCashierViewController.swift
//  Kreditomat
//
//  Created by kairzhan on 5/11/21.
//

import UIKit

class AttachCashierViewController: ViewController, ViewHolder, AttachCashierModule {
    typealias RootViewType = AttachCashierView
    
    private var pointPickerDelegate: PointPickerViewDelegate
    private var pointPickerDataSource: PointPickerViewDataSource
    private let pointPickerView = UIPickerView()
    
    init() {
        self.pointPickerDataSource = PointPickerViewDataSource()
        self.pointPickerDelegate = PointPickerViewDelegate()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = AttachCashierView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPointPickerView()
        title = "Прикрепить кассира"
    }
    
    private func setupPointPickerView() {
        pointPickerView.delegate = pointPickerDelegate
        pointPickerView.dataSource = pointPickerDataSource
        rootView.pointsList.textField.inputView = pointPickerView
    }
    
    override func customBackButtonDidTap() {
        navigationController?.popViewController(animated: true)
    }
}
