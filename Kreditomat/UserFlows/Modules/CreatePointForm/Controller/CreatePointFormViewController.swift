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
        navigationController?.navigationBar.layer.addShadow()
        title = "Создать точку"
    }
    
    private func bindView() {
        let output = viewModel.transform(input:
                                            .init(loadDay: rx.methodInvoked(#selector(viewWillAppear(_:))).map { _ in},
                                                  createPointTapped: rootView.createButton.rx.tap.asObservable()))
        
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
        
        rootView.pointNameTextField.textField.rx.text.unwrap()
            .subscribe(onNext: { [unowned self] text in
                self.viewModel.name = text
            }).disposed(by: disposeBag)
        
        cityPickerDelegate.selectedCity
            .subscribe(onNext: { [unowned self] city in
                rootView.cityList.textField.text = city.name
            }).disposed(by: disposeBag)
        
        rootView.cityList.textField.rx.text.unwrap()
            .subscribe(onNext: { [unowned self] text in
                self.viewModel.city = text
            }).disposed(by: disposeBag)
        
        rootView.streetList.textField.rx.text.unwrap()
            .subscribe(onNext: { [unowned self] text in
                self.viewModel.address = text
            }).disposed(by: disposeBag)
        
        rootView.houseNumberTextField.rx.text.unwrap()
            .subscribe(onNext: { [unowned self] text in
                self.viewModel.house = text
            }).disposed(by: disposeBag)
        
        rootView.officeNumberTextField.rx.text.unwrap()
            .subscribe(onNext: { [unowned self] text in
                self.viewModel.apartments = text
            }).disposed(by: disposeBag)
        
        Observable.combineLatest(rootView.startDayTextField.textField.rx.text.unwrap(),
                                 rootView.endDayTextField.textField.rx.text.unwrap(),
                                 rootView.startTimeTextField.rx.text.unwrap(),
                                 rootView.endTimeTextField.timeTextObservable)
            .subscribe(onNext:  { [unowned self] startDay, endDay, startTime, endTime in
                self.viewModel.workingTime = "\(startDay)-\(endDay); \(startTime)-\(endTime)"
            }).disposed(by: disposeBag)
            
        
        let createPoint = output.createPoint.publish()
        
        createPoint.element
            .subscribe(onNext: { [unowned self] result in
                if result.Success == true {
                    dismiss(animated: true) {
                        showSuccessAlert {
                        }
                    }
                } else {
                    self.showErrorInAlert(text: result.Message)
                }
            }).disposed(by: disposeBag)
        
        createPoint.connect()
            .disposed(by: disposeBag)
        
        createPoint.errors
            .bind(to: rx.error)
            .disposed(by: disposeBag)
        
        createPoint.loading
            .bind(to: ProgressView.instance.rx.loading)
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
