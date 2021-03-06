//
//  Images.swift
//  Kreditomat
//
//  Created by kairzhan on 5/9/21.
//

import UIKit

enum Images: String {
    case addProfileImage
    case download
    case acountImage
    case success
    case arrowbottom
    case lock
    case Border
    case checkboxSelected
    case checkboxUnselected
    case edit
    case previousArrow
    case back
    case question
    case back_black
    case placeholder
    case logo
    case titleLogo
    case cashier
}

extension Images {
    var image: UIImage? {
        return UIImage(named: rawValue)
    }
}
