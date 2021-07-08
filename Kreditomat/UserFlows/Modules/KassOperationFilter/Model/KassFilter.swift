import Foundation

struct KassFilter {
    let firstData: String?
    let secondData: String?
    let periodType: Int?
    
    private let propertyFormattter = assembler.resolver.resolve(PropertyFormatter.self)!

    init(firsDate: Date, secondDate: Date, period: Int?) {
        self.periodType = period
        firstData = propertyFormattter.string(from: firsDate, type: .birthday)
        secondData = propertyFormattter.string(from: secondDate, type: .birthday)
    }
}
