//
//  KassOperationFilterViewController.swift
//  Kreditomat
//
//  Created by Чингиз Куандык on 31.05.2021.
//

import UIKit

class KassOperationFilterViewController: UIViewController, KassOperationFilterModule, ViewHolder {
    typealias RootViewType = KassOperationFilterView
    
    override func loadView() {
        view = KassOperationFilterView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
