//
//  SuccessViewController.swift
//  Kreditomat
//
//  Created by kairzhan on 5/10/21.
//

import UIKit
import RxSwift

class SuccessViewController: ViewController, ViewHolder, SuccessModule {
    var closeTapped: CloseTapped?
    
    typealias RootViewType = SuccessView
    private let data: qrResult
    private let disposeBag = DisposeBag()
    private var titleText = ""
    private var checkoutData: CheckoutData
    
    override func loadView() {
        view = SuccessView()
    }
    
    init(data: qrResult, titleText: String, checkoutData: CheckoutData) {
        self.data = data
        self.titleText = titleText
        self.checkoutData = checkoutData
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindView()
        navigationController?.navigationBar.layer.addShadow()
    }
    
    private func bindView() {
        rootView.setData(data: data, checkoutData: checkoutData)
        rootView.closeButton.rx.tap
            .subscribe(onNext: { [unowned self] in
                self.closeTapped?()
            }).disposed(by: disposeBag)
        rootView.clientTitleLabel.text = titleText
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
}
