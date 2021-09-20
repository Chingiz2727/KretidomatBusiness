import Foundation

struct KassFilter {
    let firstData: String?
    let secondData: String?
    let periodType: Int?
    
    private let propertyFormattter = assembler.resolver.resolve(PropertyFormatter.self)!

    init(firsDate: String?, secondDate: String?, period: Int?) {
        self.periodType = period
        self.firstData = firsDate
        self.secondData = secondDate
    }
}
