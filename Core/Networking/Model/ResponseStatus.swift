import Alamofire

public struct ResponseStatus: Codable {
    public let ErrorCode: Int
    public let Message: String
    public let Success: Bool
}


