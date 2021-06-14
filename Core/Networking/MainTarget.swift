import Foundation

enum MainTarget: ApiTarget {
    
    case createCashRequest(type: Int, sum: Int, point: Int)
    case getActualPoints
    case registerPoint(name: String, email: String, city: String, address: String, house: String, apartments: String, bin: String, posLat: String, posLng: String, workingTime: String)
    case payHistory(dateFrom: String, dateTo: String, filter: Int, point: Int, type: OperationType)
    
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
        case .payHistory(_,_,_,_,let type):
            return type.rawValue
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
        case .payHistory:
            return .post
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
        case let.payHistory(dateFrom, dateTo, filter, point, _):
        return ["DateFrom": dateFrom, "DateTo": dateTo, "Filter": filter, "Point": point]
        }
    }
    
    var stubData: Any {
        switch self {
        case .payHistory:
            [
              "Success" : true,
              "Message" : "ok",
              "ErrorCode" : 0,
              "Data" : [
                "DateTo" : "2021-06-01T00:00:00",
                "TotalMinus" : 0,
                "SellerBalanceOperations": [
                    [
                    "Date": "2021-04-01",
                    "Sum": 2000.00,
                    "ClientPhone": "77011234567",
                    "SellerName": "Иванов Иван",
                    "SellerBalanceType": 1,
                    "RequestID": 123
                    ],
                    [
                    "Date": "2021-04-01",
                    "Sum": 2000.00,
                    "ClientPhone": "77011234567",
                    "SellerName": "Иванов Иван",
                    "SellerBalanceType": 1,
                    "RequestID": 123
                    ],
                    [
                    "Date": "2021-04-01",
                    "Sum": 2000.00,
                    "ClientPhone": "77011234567",
                    "SellerName": "Иванов Иван",
                    "SellerBalanceType": 1,
                    "RequestID": 123
                    ]
                ],
                "Date" : "2021-05-25T00:00:00",
                "TotalPlus" : 0,
                "TotalSum" : 0
              ]
            ] as [String : Any]
        default:
            return [:]
        }
        return [:]
    }
    
}

