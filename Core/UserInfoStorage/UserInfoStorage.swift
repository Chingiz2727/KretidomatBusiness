public final class UserInfoStorage {
    
    static let shared = UserInfoStorage()
    
    @UserDefaultsEntry("sellerId", defaultValue: nil)
    public var sellerId: Int?
    
    @UserDefaultsEntry("AlterNames", defaultValue: nil)
    public var alterNames: String?

    @UserDefaultsEntry("RegCode", defaultValue: nil)
    public var RegCode: Int?
    
    @UserDefaultsEntry("Name", defaultValue: nil)
    public var Name: String?
    
    @UserDefaultsEntry("Email", defaultValue: nil)
    public var Email: String?
    
    @UserDefaultsEntry("Phone", defaultValue: nil)
    public var Phone: String?
    
    @UserDefaultsEntry("City", defaultValue: nil)
    public var City: String?
    
    @UserDefaultsEntry("Address", defaultValue: nil)
    public var Address: String?
    
    @UserDefaultsEntry("House", defaultValue: nil)
    public var House: String?
    
    @UserDefaultsEntry("Apartments", defaultValue: nil)
    public var Apartments: String?
    
    @UserDefaultsEntry("BIN", defaultValue: nil)
    public var BIN: String?
    
    @UserDefaultsEntry("UniqueCode", defaultValue: nil)
    public var UniqueCode: Int?
    
    @UserDefaultsEntry("Balance", defaultValue: nil)
    public var Balance: Int?
    
    @UserDefaultsEntry("BonusSum", defaultValue: nil)
    public var BonusSum: Int?
    
    @UserDefaultsEntry("CashierID", defaultValue: nil)
    public var CashierID: Int?
    
    
    @UserDefaultsEntry("CashierName", defaultValue: nil)
    public var CashierName: String?
    
    @UserDefaultsEntry("CashierPhone", defaultValue: nil)
    public var CashierPhone: String?
    
    @UserDefaultsEntry("Role", defaultValue: nil)
    public var Role: String?
    
    
    public init() {}

    var menu: [Menu] {
        if Role ?? "" == "Agent" {
            return Menu.allCases
        } else {
            return [.mainPage,.getCredit,.clearCredit,.aboutBonus,.aboutKassa,.changePassWord,.share,.logout]
        }
    }
    
    public func save(cabinetData: CabinetData) {
        sellerId = cabinetData.SellerID
        alterNames = cabinetData.AlterNames
        RegCode = cabinetData.RegCode
        Name = cabinetData.Name
        Email = cabinetData.Email
        Phone = cabinetData.Phone
        City = cabinetData.City
        Address = cabinetData.Address
        House = cabinetData.House
        Apartments = cabinetData.Apartments
        BIN = cabinetData.BIN
        UniqueCode = cabinetData.UniqueCode
        Balance = cabinetData.Balance
        BonusSum = cabinetData.BonusSum
        CashierID = cabinetData.CashierID
        CashierName = cabinetData.CashierName
        CashierPhone = cabinetData.CashierPhone
        Role = cabinetData.Role.rawValue
    }
    
    public func clearAll() {
        
    }
}
