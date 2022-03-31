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
    private let userInfo = assembler.resolver.resolve(LoadUserInfo.self)
    
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
        bindView()
        userInfo?.savedInfo = { [weak self] in
            self?.rootView.setupData()
        }
        let storage = UserInfoStorage.shared
        
        if let imageBase = storage.Photo {
            rootView.profileImage.image = convertBase64StringToImage(imageBase64String: imageBase)
        }
        
        navigationController?.navigationBar.layer.addShadow()
        title = "Личный кабинет"
    }
    
    @objc func handleEdit() {
        
    }
    
    private func bindView() {
        let output = viewModel.transform(input: .init(userInfo: rx.methodInvoked(#selector(viewWillAppear(_:))).map { _ in}))

        let loadGetProfile = output.loadUserInfo.publish()
            
        loadGetProfile.element
            .subscribe(onNext: { [ unowned self] res in
                let image = res.Data
                
                self.rootView.profileImage.image = convertBase64StringToImage(imageBase64String: image.Photo ?? "")
                UserInfoStorage.shared.save(cabinetData: res.Data)
                self.rootView.setupData()
            }).disposed(by: disposeBag)
        
        loadGetProfile.loading
            .bind(to: ProgressView.instance.rx.loading)
            .disposed(by: disposeBag)
        
        loadGetProfile.errors
            .bind(to: rx.error)
            .disposed(by: disposeBag)
        
        loadGetProfile.connect()
            .disposed(by: disposeBag)
        
        rootView.addImageButton.rx.tap
            .subscribe(onNext: { [unowned self] in
                getImage()
            }).disposed(by: disposeBag)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(bindPhoto))
        rootView.profileImageView.isUserInteractionEnabled = true
        rootView.profileImageView.addGestureRecognizer(gesture)
    }
    
    @objc func bindPhoto() {
        let manager = ImagePickerManager()
        manager.pickImage(self) { image in
            
            self.bindUploadPhoto(img: image)
        }
    }
    
    private func getImage() {
        let manager = ImagePickerManager()
        manager.pickImage(self) { image in
            
            self.bindUploadPhoto(img: image)
        }
    }
    
    override func customBackButtonDidTap() {
        navigationController?.popViewController(animated: true)
    }
    
    private func bindUploadPhoto(img: UIImage?) {
        guard let image = img?.jpegData(compressionQuality: 0.4)?.base64EncodedString() else { return }
        
        let target = userInfo?.uploadPhoto(photo: image)
        
        let output = target?.publish()
        
        output?.element.subscribe(onNext: { [unowned self] status in
            if status.Success == true {
                self.rootView.profileImage.image = img
                self.userInfo?.loadUserInfo()
            } else {
                self.showErrorInAlert(text: status.Message)
            }
        })
        .disposed(by: disposeBag)
        
        output?.loading.bind(to: ProgressView.instance.rx.loading)
            .disposed(by: disposeBag)
        
        output?.connect()
            .disposed(by: disposeBag)
    }
    
    func convertBase64StringToImage (imageBase64String:String) -> UIImage? {
        let imageData = Data.init(base64Encoded: imageBase64String, options: .init(rawValue: 0))
        let image = UIImage(data: imageData!)
        return image
    }
}
extension UIImage {
    func toBase64() -> String? {
        guard let imageData = self.jpegData(compressionQuality: 0.3) else { return nil }
        
        return imageData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
    }
}
