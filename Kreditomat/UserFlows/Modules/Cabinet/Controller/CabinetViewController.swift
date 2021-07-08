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
    private let data: CabinetData
    private let viewModel: CabinetViewModel
    
    init(viewModel: CabinetViewModel, data: CabinetData) {
        self.viewModel = viewModel
        self.data = data
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
        bindView()
        navigationController?.navigationBar.layer.addShadow()
        title = "Личный кабинет"
    }
    
    @objc func handleEdit() {
        
    }
    
    private func bindView() {
        rootView.addImageButton.rx.tap
            .subscribe(onNext: { [unowned self] in
                ImagePickerManager().pickImage(self) { (image) in
                    rootView.profileImage.image = image
                }
            }).disposed(by: disposeBag)
        
        rootView.setupData(data: data)
    }
    
    override func customBackButtonDidTap() {
        navigationController?.popViewController(animated: true)
    }
}
