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
}

extension Images {
    var image: UIImage? {
        return UIImage(named: rawValue)
    }
}
