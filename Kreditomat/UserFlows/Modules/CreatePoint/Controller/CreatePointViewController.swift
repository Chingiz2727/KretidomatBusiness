//
//  CreatePointViewController.swift
//  Kreditomat
//
//  Created by kairzhan on 5/10/21.
//
import RxSwift
import UIKit

class CreatePointViewController: ViewController, ViewHolder, CreatePointModule {
    var create: Create?
    typealias RootViewType = CreatePointView
    private var blockPointSubject = PublishSubject<Void>()
    private var blockCashierSubject = PublishSubject<Void>()
        
    private var pointPickerDelegate: PointPickerViewDelegate
    private var pointPickerDataSource: PointPickerViewDataSource
    private let pointPickerView = UIPickerView()
    private let disposeBag = DisposeBag()
    private let viewModel: CreatePointViewModel
    
    init(viewModel: CreatePointViewModel) {
        self.pointPickerDataSource = PointPickerViewDataSource()
        self.pointPickerDelegate = PointPickerViewDelegate()
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = CreatePointView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindView()
        setupPointPickerView()
        navigationController?.navigationBar.layer.addShadow()
        title = "Создать точку"
    }
    
    private func bindView() {
        rootView.tableView.registerClassForCell(PointCell.self)
        rootView.createButton.rx.tap
            .subscribe(onNext: { [unowned self] in
                self.create?()
            }).disposed(by: disposeBag)
        let output = viewModel.transform(input: .init(loadPoints: .just(()), pointBlock: blockPointSubject, cashierBlock: blockCashierSubject))
        
        rootView.blockPointCallback = { [unowned self] point in
//            presentCustomAlert(type: .blockPoint(name: point.Name ?? "")) {
//                blockPointSubject.onNext(())
//            } secondButtonAction: {
//                dismiss(animated: true, completion: nil)
//            }
        }
        
        rootView.blockCashierCallback = { [unowned self] point in
            presentCustomAlert(type: .unblockKassir(fio: point.CashierName ?? "")) {
                blockCashierSubject.onNext(())
            } secondButtonAction: {
                dismiss(animated: true, completion: nil)
            }
        }
        
        let cashierBlock = output.cashierBlockRes.publish()
        
        cashierBlock.element
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
        
        cashierBlock.loading
            .bind(to: ProgressView.instance.rx.loading)
            .disposed(by: disposeBag)
        
        cashierBlock.errors
            .bind(to: rx.error)
            .disposed(by: disposeBag)
        
        cashierBlock.connect()
            .disposed(by: disposeBag)
        
        let pointBlock = output.pointBlockRes.publish()
        
        pointBlock.element
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
        
        pointBlock.loading
            .bind(to: ProgressView.instance.rx.loading)
            .disposed(by: disposeBag)
        
        pointBlock.errors
            .bind(to: rx.error)
            .disposed(by: disposeBag)
        
        pointBlock.connect()
            .disposed(by: disposeBag)
        
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
        
        pointPickerDelegate.selectedPoint
            .subscribe(onNext: { [unowned self] res in
                self.viewModel.sellerUserId = res.CashierID ?? 0
                self.viewModel.sellerId = res.SellerID ?? 0
                rootView.points = [res]
                rootView.tableView.reloadData()
                rootView.pointsList.textField.text = res.Name
            }).disposed(by: disposeBag)
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
