import KeychainAccess
import Foundation
import UIKit

protocol AuthTokenService {
  var token: UserResponse? { get }

  func set(token: UserResponse?)
}

final class AuthTokenServiceImpl: AuthTokenService {

  private let encoder = JSONEncoder()
  private let decoder = JSONDecoder()
  private let keychain = Keychain(server: "https://sertlombard.kz", protocolType: .https)

  private(set) var token: UserResponse? {
    get {
      guard
        let data = try? keychain.getData(Constants.tokenKey),
        let token = try? decoder.decode(UserResponse.self, from: data) else { return nil }
        return token
    }
    set {
      let encodedData = try? encoder.encode(newValue)
      keychain[data: Constants.tokenKey] = encodedData
    }
  }
}

extension AuthTokenServiceImpl {
  func set(token: UserResponse?) {
    self.token = token
  }
}

private extension AuthTokenServiceImpl {
  struct Constants {
    static let tokenKey = "stored_oauth_token_key_for_sert_lombard"
  }
}
