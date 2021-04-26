public final class UserInfoStorage {
    @UserDefaultsEntry("iinNumber", defaultValue: nil)
    public var iin: String?
    
    @UserDefaultsEntry("fullName", defaultValue: nil)
    public var fullName: String?

    @UserDefaultsEntry("mobilePhoneNumber", defaultValue: nil)
    public var mobilePhoneNumber: String?
    
    public init() {}

    public func clearAll() {
        iin = ""
        fullName = ""
        mobilePhoneNumber = ""
    }
}
