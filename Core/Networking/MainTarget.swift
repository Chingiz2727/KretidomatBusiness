import Foundation

enum MainTarget: ApiTarget {
    
    case createCashRequest(type: Int, sum: Int, point: Int)
    case getActualPoints
    case payHistory(dateFrom: String, dateTo: String, filter: Int, point: Int, type: OperationType)
    case registerPoint(name: String, email: String, phone: String, city: String, address: String, house: String, apartments: String, bin: String, posLat: String, posLng: String, workingTime: String)
    
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
        case let .registerPoint(name, email, phone, city, address, house, apartments, bin, posLat, posLng, workingTime):
            return ["Name": name,
                    "Email": email,
                    "Phone": phone,
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

