//
//  CabinetViewController.swift
//  Kreditomat
//
//  Created by kairzhan on 5/9/21.
//

import UIKit
import RxSwift

class CabinetViewController: ViewController, ViewHolder, CabinetModule {
    typealias RootViewType = CabinetView
    
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        view = CabinetView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindView()
    }
    
    private func bindView() {
        rootView.addImageButton.rx.tap
            .subscribe(onNext: { [unowned self] in
                ImagePickerManager().pickImage(self) { (image) in
                    rootView.profileImage.image = image
                }
            }).disposed(by: disposeBag)
    }
}