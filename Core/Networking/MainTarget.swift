import Foundation

enum MainTarget: ApiTarget {
    
    case createCashRequest(type: Int, sum: Int, point: Int)
    case getActualPoints
    case registerPoint(name: String, email: String, city: String, address: String, house: String, apartments: String, bin: String, posLat: String, posLng: String, workingTime: String)
    
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
        case let .registerPoint(name, email, city, address, house, apartments, bin, posLat, posLng, workingTime):
            return ["Name": name,
                    "Email": email,
                    "City": city,
                    "Address": address,
                    "House": house,
                    "Apartments": apartments,
                    "BIN": bin,
                    "Pos_Lat": posLat,
                    "Pos_Lng": posLng,
                    "WorkingTime": workingTime]
        }
    }
    
    var stubData: Any { [:] }
    
}

