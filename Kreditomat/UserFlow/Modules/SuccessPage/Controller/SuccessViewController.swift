//
//  SuccessViewController.swift
//  Kreditomat
//
//  Created by kairzhan on 5/10/21.
//

import UIKit

class SuccessViewController: ViewController, ViewHolder, SuccessModule {
    typealias RootViewType = SuccessView
    
    override func loadView() {
        view = SuccessView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
