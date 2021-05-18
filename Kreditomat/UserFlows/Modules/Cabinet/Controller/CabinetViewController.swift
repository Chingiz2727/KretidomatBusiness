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
    private let viewModel: CabinetViewModel
    
    init(viewModel: CabinetViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = CabinetView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for family in UIFont.familyNames.sorted() {
            let names = UIFont.fontNames(forFamilyName: family)
            print("Family: \(family) name: \(names)")
        }
        bindView()
    }
    
    private func bindView() {
        rootView.addImageButton.rx.tap
            .subscribe(onNext: { [unowned self] in
                ImagePickerManager().pickImage(self) { (image) in
                    rootView.profileImage.image = image
                }
            }).disposed(by: disposeBag)
        
        let output = viewModel.transform(input: .init(loadInfo: .just(())))
        
        let info = output.info.publish()
        
        info.element
            .subscribe(onNext: { [unowned self] info in
                rootView.setupData(data: info.Data)
            }).disposed(by: disposeBag)
        
        info.errors
            .bind(to: rx.error)
            .disposed(by: disposeBag)
        
        info.loading
            .bind(to: ProgressView.instance.rx.loading)
            .disposed(by: disposeBag)
        
        info.connect()
            .disposed(by: disposeBag)
    }
}
