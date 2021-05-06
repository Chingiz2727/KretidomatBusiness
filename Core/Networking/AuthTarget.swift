import Foundation

enum AuthTarget: ApiTarget {
//    case authUser(phone: String, password: String)
    case checkUser(iin: String)
    case sendSms(phone: String)
    case verification(phone: String, activateCode: String)
    case signUp(iin: String, phone: String, ftoken: String, password: String, password2: String)
    case signIn(iin: String, password: String)
    case resetPassword(iin: String, phone: String, password: String, password2: String)
    
    var servicePath: String  { "/auth" }
    var version: ApiVersion {
        .number(1)
    }
    
    var path: String {
        switch self {
        case .checkUser:
            return "/check-user"
        case .sendSms:
            return "/sms"
        case .verification:
            return "/verification"
        case .signUp:
            return "/sign-up"
        case .signIn:
            return "/sign-in"
        case .resetPassword:
            return "/reset"
        }
        
    }
    
    var method: HTTPMethod {
        return .post
    }
    
    var parameters: [String : Any]? {
        switch self {
        
        case .checkUser(let iin):
            return ["iin" : iin]
        case .sendSms(let phone):
            return ["phone" : phone]
        case let .verification(phone, activateCode):
            print("user phone", phone)
            print("user code", activateCode)
            let param = ["phone": phone,
                         "activationcode": activateCode]
            
            return param
        case let .signUp(iin, phone, ftoken, password, password2):
            let param = [ "iin" : iin,
                          "phone" : phone,
                          "ftoken" : ftoken,
                          "password" : password,
                          "password2" : password2
            ] as [String : Any]
            return param
        case let .signIn(iin, password):
            let param = [ "iin" : iin,
//                          "ftoken" : ftoken.toBase64(),
                          "password" : password
            ] as [String : Any]
            return param
        case let .resetPassword(iin, phone, password, password2):
            let param = [ "iin" : iin,
                          "phone" : phone,
                          "password" : password,
                          "password2" : password2
            ] as [String : Any]
            return param
        }
    }
    
    var stubData: Any { return [:] }
    
    var headers: [String : String]? {
        switch self {
        case .checkUser, .sendSms, .verification, .signUp, .signIn, .resetPassword:
            return ["appver": "1.0.0"]
        }
    }
}
