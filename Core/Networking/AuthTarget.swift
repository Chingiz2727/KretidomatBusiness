import Foundation

enum AuthTarget: ApiTarget {
    case authUser(phone: String, password: String)
    case register(name: String, email: String, phone: String, city: String, address: String, house: String, apartments: String, bin: String, posLat: String, posLng: String)
    case resetPassword(iin: String, phone: String, password: String, password2: String)
    
    var servicePath: String  { "" }
    var version: ApiVersion {
        .custom("")
    }
    
    var path: String {
        switch self {
        case .authUser:
            return "Auth"
        case .register:
            return "Register"
        case .resetPassword:
            return "ResetPassword"
        }
        
    }
    
    var method: HTTPMethod {
        switch self {
        case .register:
            return .put
        default:
            return .post
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        
        case let .authUser(phone, password):
            return ["Phone": phone,
                    "Password": password]
        case let .register(name, email, phone, city, address, house, apartments, bin, posLat, posLng):
            return ["Name": name,
                    "Email": email,
                    "Phone": phone,
                    "City": city,
                    "Address": address,
                    "House": house,
                    "Apartments": apartments,
                    "BIN": bin,
                    "Pos_Lat": posLat,
                    "Pos_Lng": posLng]
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
    
    var headers: [String : String]? { return [:] }

}
