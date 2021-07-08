//
//  SignatureViewController.swift
//  Kreditomat
//
//  Created by Чингиз Куандык on 11.05.2021.
//

import UIKit
import RxSwift

class SignatureViewController: ViewController, SignatureModule, ViewHolder {
    var errorTapped: Callback?
    var showSucces: ShowSuccess?
    
    typealias RootViewType = SignatureView
    
    private let disposeBag = DisposeBag()
    private let data: qrResult
    private let viewModel: GiveCreditViewModel
    
    var onTapSubmit: OnTapSubmit?

    override func loadView() {
        view = SignatureView()
    }
    
    init(data: qrResult, viewModel: GiveCreditViewModel) {
        self.data = data
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindView()
    }
    
    private func bindView() {
        rootView.repeatButton.rx.tap
            .subscribe(onNext: { [unowned self] in
                self.rootView.drawerView.clearDrawing()
            })
            .disposed(by: disposeBag)
        
        rootView.confirmButton.rx.tap
            .subscribe(onNext: { [unowned self] in
                presentCustomAlert(type: .giveCredit(sum: "\(data.CreditSum)", fio: data.FIO)) {
                    self.viewModel.clientId = data.ClientID
                    self.viewModel.creditId = data.CreditID
                    let img = rootView.drawerView.exportDrawing().jpegData(compressionQuality: 0.8)?.base64EncodedString()
                    self.viewModel.sig = img ?? ""
                    let give = self.viewModel.transform(input: .init(giveTapped: .just(())))
                    let output = give.response.publish()
                    
                    output.element
                        .subscribe(onNext: { [unowned self] res in
                            if res.Success {
                                self.dismiss(animated: true) {
                                    self.showSucces?(data, res.Data)
                                }
                            } else {
                                self.dismiss(animated: true) {
                                    showErrorAlert(title: "Ошибка", message: res.Message) {
                                        self.errorTapped?()
                                    }
                            }
                            }}).disposed(by: disposeBag)
                    
                    output.loading
                        .bind(to: ProgressView.instance.rx.loading)
                        .disposed(by: disposeBag)
                    
                    output.errors
                        .bind(to: rx.error)
                        .disposed(by: disposeBag)
                    
                    output.connect()
                        .disposed(by: disposeBag)
                    
                } secondButtonAction: {
                    self.dismiss(animated: true) {
                        //self.navigationController?.popViewController(animated: true)
                    }
                }

            }).disposed(by: disposeBag)
        
        title = "Выдача микрокредита"
    }
    
    override func customBackButtonDidTap() {
        navigationController?.popViewController(animated: true)
    }
}
