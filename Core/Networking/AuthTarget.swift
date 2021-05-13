import Foundation

enum AuthTarget: ApiTarget {
    case authUser(phone: String, password: String)
    case checkUser(iin: String)
    case sendSms(phone: String)
    case verification(phone: String, activateCode: String)
    case signUp(iin: String, phone: String, ftoken: String, password: String, password2: String)
    case signIn(iin: String, password: String)
    case resetPassword(phone: String, email: String)
    
    var servicePath: String  { "" }
    var version: ApiVersion {
        .custom("")
    }
    
    var path: String {
        switch self {
        case .authUser:
            return "Auth"
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
            return "ResetPassword"
        }
        
    }
    
    var method: HTTPMethod {
        return .post
    }
    
    var parameters: [String : Any]? {
        switch self {
        
        case let .authUser(phone, password):
            return ["Phone": phone,
                    "Password": password]
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
        case let .resetPassword(phone, email):
            return [ "Phone" : phone,
                     "Email" : email]
        }
    }
    
    var stubData: Any { return [:] }
    
    var headers: [String : String]? { return [:] }
//    var headers: [String : String]? {
//        switch self {
//        case .checkUser, .sendSms, .verification, .signUp, .signIn, .resetPassword:
//            return ["appver": "1.0.0"]
//        }
//    }
}
