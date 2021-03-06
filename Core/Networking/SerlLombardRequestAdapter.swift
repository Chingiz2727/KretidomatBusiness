import Foundation
import Alamofire

public struct SertLombardRequestAdapter: RequestAdapter {
    public var authService: AuthenticationService!
    public var configService: ConfigService!
    
    public func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var resultRequest = urlRequest
        let userSession = assembler.resolver.resolve(UserSessionStorage.self)!
        
        if let token = userSession.accessToken {
            
            resultRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        return resultRequest
    }
    
    private func adaptedUrl(_ url: URL?) -> URL? {
        guard let url = url else { return nil }
        return URL(string: url.absoluteString.replacingOccurrences(of: ApiPath.userId, with: ""))!
    }
    
    
}
