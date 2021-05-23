//
//  OfertaViewController.swift
//  Kreditomat
//
//  Created by kairzhan on 5/20/21.
//

import UIKit

class OfertaViewController: ViewController, ViewHolder, OfertaModule {
    typealias RootViewType = OfertaView
    
    override func loadView() {
        view = OfertaView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Условия оферты"
    }
    
    override func customBackButtonDidTap() {
        navigationController?.popViewController(animated: true)
    }
}
