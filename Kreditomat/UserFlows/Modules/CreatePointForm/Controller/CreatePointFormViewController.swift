//
//  CreatePointFormViewController.swift
//  Kreditomat
//
//  Created by kairzhan on 5/12/21.
//

import UIKit
import RxSwift

class CreatePointFormViewController: ViewController, ViewHolder, CreatePointFormModule {
    typealias RootViewType = CreatePointFormView
    
    private var startDayPickerDelegate: StartDayPickerViewDelegate
    private var endDayPickerDelegate: EndDayPickerViewDelegate
    private var dayPickerDataSource: DayPickerViewDataSource
    private let startDayPickerView = UIPickerView()
    private let endDayPickerView = UIPickerView()
    private var cityPickerDelegate: CityPickerViewDelegate
    private var cityPickerDataSource: CityPickerViewDataSource
    private let cityPickerView = UIPickerView()
    private let viewModel: CreatePointFormViewModel
    private let disposeBag = DisposeBag()
    
    init(viewModel: CreatePointFormViewModel) {
        self.startDayPickerDelegate = StartDayPickerViewDelegate()
        self.endDayPickerDelegate = EndDayPickerViewDelegate()
        self.dayPickerDataSource = DayPickerViewDataSource()
        self.cityPickerDelegate = CityPickerViewDelegate()
        self.cityPickerDataSource = CityPickerViewDataSource()
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = CreatePointFormView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindView()
        setupPickersView()
        title = "Создать точку"
    }
    
    private func bindView() {
        let output = viewModel.transform(input: .init(loadDay: rx.methodInvoked(#selector(viewWillAppear(_:))).map { _ in  }))
        
        let day = output.getDay.publish()
        
        day.subscribe(onNext: { [unowned self] day in
            self.startDayPickerDelegate.day = day
            self.endDayPickerDelegate.day = day
            self.dayPickerDataSource.day = day
            self.startDayPickerView.reloadAllComponents()
            self.endDayPickerView.reloadAllComponents()
        }).disposed(by: disposeBag)
        
        startDayPickerDelegate.selectedDay
            .subscribe(onNext: { [unowned self] day in
                rootView.startDayTextField.textField.text = day.shortName
            }).disposed(by: disposeBag)
        
        endDayPickerDelegate.selectedDay
            .subscribe(onNext: { [unowned self] day in
                rootView.endDayTextField.textField.text = day.shortName
            }).disposed(by: disposeBag)
        
        day.connect()
            .disposed(by: disposeBag)
    }
    
    private func setupPickersView() {
        startDayPickerView.delegate = startDayPickerDelegate
        endDayPickerView.delegate = endDayPickerDelegate
        startDayPickerView.dataSource = dayPickerDataSource
        endDayPickerView.dataSource = dayPickerDataSource
        rootView.startDayTextField.textField.inputView = startDayPickerView
        rootView.endDayTextField.textField.inputView = endDayPickerView
        cityPickerView.delegate = cityPickerDelegate
        cityPickerView.dataSource = cityPickerDataSource
        rootView.cityList.textField.inputView = cityPickerView
    }
    
    override func customBackButtonDidTap() {
        navigationController?.popViewController(animated: true)
    }
}
