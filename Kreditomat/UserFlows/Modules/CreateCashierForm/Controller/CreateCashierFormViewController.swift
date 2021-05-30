//
//  CreateCashierFormViewController.swift
//  Kreditomat
//
//  Created by kairzhan on 5/24/21.
//

import UIKit
import RxSwift

class CreateCashierFormViewController: ViewController, ViewHolder, CreateCashierFormModule {
    typealias RootViewType = CreateCashierFormView
    private let disposeBag = DisposeBag()
    private let viewModel: CreateCashierFormViewModel
    
    init(viewModel: CreateCashierFormViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = CreateCashierFormView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Создать кассира"
        bindView()
    }
    
    override func customBackButtonDidTap() {
        navigationController?.popViewController(animated: true)
    }
    
    private func bindView() {
        let output = viewModel.transform(
            input: .init(
                name: rootView.nameCashierTextField.textField.rx.text.asObservable(), phone: rootView.phoneCashierTextField.rx.text.asObservable(), createTapped: rootView.createButton.rx.tap.asObservable()))
        
        let response = output.response.publish()
        
        response.element
            .subscribe(onNext: { [unowned self] response in
                if response.Success {
                    showSuccessAlert {
                        self.navigationController?.popViewController(animated: true)
                    }
                } else {
                    showErrorInAlert(text: "Что-то пошло не так")
                }
            }).disposed(by: disposeBag)
        
        response.loading
            .bind(to: ProgressView.instance.rx.loading)
            .disposed(by: disposeBag)
        
        response.errors
            .bind(to: rx.error)
            .disposed(by: disposeBag)
        
        response.connect()
            .disposed(by: disposeBag)
    }
}
