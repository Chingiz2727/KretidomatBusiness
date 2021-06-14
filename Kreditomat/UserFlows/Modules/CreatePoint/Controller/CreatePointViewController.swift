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
        
    private var pointPickerDelegate: PointPickerViewDelegate
    private var pointPickerDataSource: PointPickerViewDataSource
    private let pointPickerView = UIPickerView()
    private let disposeBag = DisposeBag()
    
    init() {
        self.pointPickerDataSource = PointPickerViewDataSource()
        self.pointPickerDelegate = PointPickerViewDelegate()
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
