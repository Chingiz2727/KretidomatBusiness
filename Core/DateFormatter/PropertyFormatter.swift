import Foundation

public final class PropertyFormatter {
    var formatters: [String: Any] = [:]
    let cachedFormattersQueue = DispatchQueue(label: "team.alabs.formatter.queue")
}

import Foundation

protocol Rangeable: AnyObject {
    var range: NSRange { get set }
}

protocol Identifiable {
    var rawValue: String { get }
}

extension Identifiable {
    var id: String { String(describing: Self.self) + rawValue }
}
