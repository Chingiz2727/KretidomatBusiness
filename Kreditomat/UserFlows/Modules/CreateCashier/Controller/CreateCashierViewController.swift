//
//  CreateCashierViewController.swift
//  Kreditomat
//
//  Created by kairzhan on 5/24/21.
//

import UIKit
import RxSwift

class CreateCashierViewController: ViewController, ViewHolder, CreateCashierModule {
    var create: Create?
    
    typealias RootViewType = CreateCashierView
    
    private var cashierPickerDelegate: CashierPickerViewDelegate
    private var cashierPickerDataSource: CashierPickerViewDataSource
    private let cashierPickerView = UIPickerView()
    private let disposeBag = DisposeBag()
    private let viewModel: CreateCashierViewModel
    
    init(viewModel: CreateCashierViewModel) {
        self.cashierPickerDataSource = CashierPickerViewDataSource()
        self.cashierPickerDelegate = CashierPickerViewDelegate()
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = CreateCashierView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.layer.addShadow()
        title = "Создать кассира"
        setupPointPickerView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bindView()
    }
    
    override func customBackButtonDidTap() {
        navigationController?.popViewController(animated: true)
    }
    
    private func bindView() {
        rootView.tableView.registerClassForCell(PointCell.self)
        rootView.createButton.rx.tap
            .subscribe(onNext: { [unowned self] in
                self.create?()
            }).disposed(by: disposeBag)
        let output = viewModel.transform(input: .init(loadInfo: .just(()), blockTapped: rootView.blockTapped))
        
        let block = output.blockResponse.publish()
        
        block.element
            .subscribe(onNext: { [unowned self] res in
                if res.Success {
                    showSuccessAlert {
                    }
                } else {
                    showSimpleAlert(title: "Ошибка", message: res.Message)
                }
            }).disposed(by: disposeBag)
        
        block.loading
            .bind(to: ProgressView.instance.rx.loading)
            .disposed(by: disposeBag)
        
        block.errors
            .bind(to: rx.error)
            .disposed(by: disposeBag)
        
        block.connect()
            .disposed(by: disposeBag)
        
        let info = output.info.publish()
        
        info.element
            .subscribe(onNext: { [unowned self] info in
                cashierPickerDataSource.cashier = info.Data
                cashierPickerDelegate.cashier = info.Data
            }).disposed(by: disposeBag)
        
        info.loading
            .bind(to: ProgressView.instance.rx.loading)
            .disposed(by: disposeBag)
        
        info.errors
            .bind(to: rx.error)
            .disposed(by: disposeBag)
        
        info.connect()
            .disposed(by: disposeBag)
        
        cashierPickerDelegate.selectedCashier
            .subscribe(onNext: { [unowned self] name in
                self.viewModel.sellerUserId = name.SellerUserID
                self.viewModel.sellerId = name.SellerID
                rootView.cashiersList.textField.text = name.Name
                rootView.cashiers = [name]
                rootView.tableView.reloadData()
            }).disposed(by: disposeBag)
    }
    
    private func setupPointPickerView() {
        cashierPickerView.delegate = cashierPickerDelegate
        cashierPickerView.dataSource = cashierPickerDataSource
        rootView.cashiersList.textField.inputView = cashierPickerView
    }
}
