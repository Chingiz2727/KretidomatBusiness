import Foundation

enum MainTarget: ApiTarget {
    
    case createCashRequest(type: Int, sum: Int, point: Int)
    case getActualPoints
    case registerPoint(name: String, email: String, phone: String, city: String, address: String, house: String, apartments: String, bin: String, posLat: String, posLng: String)
    
    var version: ApiVersion { .custom("") }
    
    var servicePath: String { return "" }
    
    var path: String {
        switch self {
        case .createCashRequest:
            return "CreateCashRequest"
        case .getActualPoints:
            return "GetActualPoints"
        case .registerPoint:
            return "RegisterPoint"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .createCashRequest:
            return .post
        case .getActualPoints:
            return .get
        case .registerPoint:
            return .put
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case let .createCashRequest(type, sum, point):
            return ["Type": type,
                    "Sum": sum,
                    "Point": point]
        case .getActualPoints:
            return [:]
        case let .registerPoint(name, email, phone, city, address, house, apartments, bin, posLat, posLng):
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
        }
    }
    
    var stubData: Any { [:] }
    
}

