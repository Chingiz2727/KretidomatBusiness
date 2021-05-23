import Foundation

enum ChangePassTarget: ApiTarget {
    case changePassword(oldPass: String, newPass: String)
    
    var version: ApiVersion { .custom("") }
    
    var servicePath: String { return "" }
    
    var path: String {
        return "UpdatePassword"
    }
    
    var method: HTTPMethod { return .post }
    
    var parameters: [String : Any]? {
        switch self {
        case let .changePassword(oldPass, newPass):
            return ["OldPassword": oldPass,
                    "NewPassword": newPass]
        }
    }
    
    var stubData: Any { [:] }
    
    
}
