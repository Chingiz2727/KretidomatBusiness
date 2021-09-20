//
//  CabinetTarget.swift
//  Kreditomat
//
//  Created by kairzhan on 5/18/21.
//

import Foundation

enum CabinetTarget: ApiTarget {
    case getInfo
    case uploadPhoto(base64: String)
    
    var version: ApiVersion {
        .custom("")
    }
    
    var servicePath: String { "" }
    
    var path: String {
        switch self {
        case .getInfo:
            return "Get"
        case .uploadPhoto:
            return "UploadPhoto"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getInfo:
            return .get
        case .uploadPhoto:
            return .put
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .getInfo:
            return [:]
        case .uploadPhoto(let base64):
            return ["Photo": base64]
        }
    }
    
    var stubData: Any { return [:] }
    
    
}
