public struct CheckUserResponse: Codable {
    let status: Int
    let data: [UserData]?
}

public struct UserData : Codable {
    let fio: String
    let phone: String
}
