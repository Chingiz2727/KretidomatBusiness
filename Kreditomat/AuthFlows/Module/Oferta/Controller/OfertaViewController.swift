//
//  OfertaViewController.swift
//  Kreditomat
//
//  Created by kairzhan on 5/20/21.
//
import WebKit
import UIKit

class OfertaViewController: ViewController, OfertaModule {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        urSearch()
    }
    
    private func urSearch() {
        if let url = Bundle.main.url(forResource: "oferta", withExtension: "docx") {
            let webView = WKWebView(frame: self.view.frame)
            view.addSubview(webView)
            title = "Условия оферты"
            let urlS = "oferta.docx"
            let request = URLRequest(url: url)
            webView.load(request)
            
        } else {
            print("Not ur;")
        }
    }
    
    override func customBackButtonDidTap() {
        navigationController?.popViewController(animated: true)
    }
}
