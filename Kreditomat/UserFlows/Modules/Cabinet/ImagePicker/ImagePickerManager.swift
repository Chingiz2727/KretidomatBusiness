//
//  ImagePickerManager.swift
//  Kreditomat
//
//  Created by kairzhan on 5/10/21.
//
import UIKit

class ImagePickerManager: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var picker = UIImagePickerController();
    var alert = UIAlertController(title: "Фото профиля", message: nil, preferredStyle: .actionSheet)
    var viewController: UIViewController?
    var pickImageCallback : ((UIImage?) -> ())?;
    
    override init(){
        super.init()
        let cameraAction = UIAlertAction(title: "Камера", style: .default){
            UIAlertAction in
            self.openCamera()
        }
        let galleryAction = UIAlertAction(title: "Галерея", style: .default){
            UIAlertAction in
            self.openGallery()
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel){
            UIAlertAction in
        }
        
        let deleteAction = UIAlertAction(title: "Удалить фото", style: .default) { alert in
            self.deletePhoto()
        }

        picker.delegate = self
        alert.addAction(deleteAction)
        alert.addAction(cameraAction)
        alert.addAction(galleryAction)
        alert.addAction(cancelAction)
    }

    func pickImage(_ viewController: UIViewController, _ callback: @escaping ((UIImage?) -> ())) {
        pickImageCallback = callback;
        self.viewController = viewController;

        alert.popoverPresentationController?.sourceView = self.viewController!.view

        viewController.present(alert, animated: true, completion: nil)
    }
    
    func openCamera(){
        alert.dismiss(animated: true, completion: nil)
        if(UIImagePickerController .isSourceTypeAvailable(.camera)){
            picker.sourceType = .camera
            self.viewController!.present(picker, animated: true, completion: nil)
        } else {
            let alertWarning = UIAlertView(title: "", message: "Разрешите доступ к камере в настройках", delegate:nil, cancelButtonTitle:"OK")
            alertWarning.show()
        }
    }
    func openGallery() {
        alert.dismiss(animated: true, completion: nil)
        picker.sourceType = .photoLibrary
        self.viewController!.present(picker, animated: true, completion: nil)
    }
    
    func deletePhoto() {
        alert.dismiss(animated: true) { [unowned self] in
            self.pickImageCallback?(UIImage())
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        pickImageCallback?(image)
    }



    @objc func imagePickerController(_ picker: UIImagePickerController, pickedImage: UIImage?) {
        picker.dismiss(animated: true) {
            self.pickImageCallback?(pickedImage)
        }
    }

}

