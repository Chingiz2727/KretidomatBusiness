//
//  CabinetTarget.swift
//  Kreditomat
//
//  Created by kairzhan on 5/18/21.
//

import Foundation

enum CabinetTarget: ApiTarget {
    case getInfo
    
    var version: ApiVersion {
        .custom("")
    }
    
    var servicePath: String { "" }
    
    var path: String {
        return "Get"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameters: [String : Any]? { [:] }
    
    var stubData: Any { return [:] }
    
    
}
