//
//  SignatureViewController.swift
//  Kreditomat
//
//  Created by Чингиз Куандык on 11.05.2021.
//

import UIKit
import RxSwift

class SignatureViewController: ViewController, SignatureModule, ViewHolder {
    typealias RootViewType = SignatureView
    
    private let disposeBag = DisposeBag()
    
    var onTapSubmit: OnTapSubmit?

    override func loadView() {
        view = SignatureView()
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
        
        title = "Выдача микрокредита"
    }
    
    override func customBackButtonDidTap() {
        navigationController?.popViewController(animated: true)
    }
}
