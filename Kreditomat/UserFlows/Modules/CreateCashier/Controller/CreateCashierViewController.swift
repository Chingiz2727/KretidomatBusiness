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
    private var pointPickerDataSource: PointPickerViewDataSource
    private var pointPickerDelegate: PointPickerViewDelegate
    private let pointPickerView = UIPickerView()
    private let disposeBag = DisposeBag()
    private let viewModel: CreateCashierViewModel
    
    private var blockCashierSubject = PublishSubject<Void>()
    
    init(viewModel: CreateCashierViewModel) {
        self.cashierPickerDataSource = CashierPickerViewDataSource()
        self.cashierPickerDelegate = CashierPickerViewDelegate()
        self.pointPickerDataSource = PointPickerViewDataSource()
        self.pointPickerDelegate = PointPickerViewDelegate()
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
        bindView()
//        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
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
        
        let output = viewModel.transform(input: .init(
            loadInfo: rx.methodInvoked(#selector(viewWillAppear(_:))).map { _ in},
            blockTapped: blockCashierSubject,
            loadPoints: rx.methodInvoked(#selector(viewWillAppear(_:))).map { _ in },
            attachTapped: rootView.attachTap))
        
        rootView.blockCashierCallback = { [unowned self] cashier in
            presentCustomAlert(type: .blockKassir(fio: cashier.Name)) {
                blockCashierSubject.onNext(())
            } secondButtonAction: {
                dismiss(animated: true, completion: nil)
            }

        }
        
        let points = output.points.publish()
        
        points.element
            .subscribe(onNext: { [unowned self] res in
                pointPickerDelegate.point = res.Data
                pointPickerDataSource.point = res.Data
            }).disposed(by: disposeBag)
        
        points.loading
            .bind(to: ProgressView.instance.rx.loading)
            .disposed(by: disposeBag)
        
        points.errors
            .bind(to: rx.error)
            .disposed(by: disposeBag)
        
        points.connect()
            .disposed(by: disposeBag)
        
        let attach = output.attachResponse.publish()
        
        attach.element
            .subscribe(onNext: { [unowned self] res in
                if res.Success {
                    showSuccessAlert {
                        
                    }
                } else {
                    showSimpleAlert(title: "Ошибка", message: res.Message)
                }
            }).disposed(by: disposeBag)
        
        attach.loading
            .bind(to: ProgressView.instance.rx.loading)
            .disposed(by: disposeBag)
        
        attach.errors
            .bind(to: rx.error)
            .disposed(by: disposeBag)
        
        attach.connect()
            .disposed(by: disposeBag)
        
        let block = output.blockResponse.publish()
        
        block.element
            .subscribe(onNext: { [unowned self] res in
                if res.Success {
                    dismiss(animated: true) {
                        showSuccessAlert {
                        }
                    }
                } else {
                    dismiss(animated: true) {
                        showSimpleAlert(title: "Ошибка", message: res.Message)
                    }
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
                guard let name = name else { return }
                self.viewModel.sellerUserId = name.SellerUserID
                rootView.cashiersList.textField.text = name.Name
                rootView.cashiers = [name]
                rootView.tableView.reloadData()
            }).disposed(by: disposeBag)
        
        pointPickerDelegate.selectedPoint
            .subscribe(onNext: { [unowned self] res in
                self.viewModel.pointId = res.SellerID ?? 0
                rootView.pointsList.textField.text = res.Name
            }).disposed(by: disposeBag)
    }
    
    private func setupPointPickerView() {
        cashierPickerView.delegate = cashierPickerDelegate
        cashierPickerView.dataSource = cashierPickerDataSource
        rootView.cashiersList.textField.inputView = cashierPickerView
        pointPickerView.delegate = pointPickerDelegate
        pointPickerView.dataSource = pointPickerDataSource
        rootView.pointsList.textField.inputView = pointPickerView
    }
}
