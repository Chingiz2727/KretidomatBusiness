import Alamofire

public struct ResponseStatus: Codable {
    public let ErorCode: Int
    public let Message: String
    public let Success: Bool
}


