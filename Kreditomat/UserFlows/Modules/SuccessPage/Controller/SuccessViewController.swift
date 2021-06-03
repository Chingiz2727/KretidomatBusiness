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
    
    override func loadView() {
        view = SuccessView()
    }
    
    init(data: qrResult) {
        self.data = data
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
        rootView.setData(data: data)
        rootView.closeButton.rx.tap
            .subscribe(onNext: { [unowned self] in
                self.closeTapped?()
            }).disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
}
