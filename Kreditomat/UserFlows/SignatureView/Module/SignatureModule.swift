import Foundation

protocol SignatureModule: Presentable {
    typealias OnTapSubmit = (Data) -> Void
    
    var onTapSubmit: OnTapSubmit? { get set }
}
