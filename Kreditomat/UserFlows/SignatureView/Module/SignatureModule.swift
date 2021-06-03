import Foundation

protocol SignatureModule: Presentable {
    typealias OnTapSubmit = (Data) -> Void
    
    var onTapSubmit: OnTapSubmit? { get set }
    typealias ShowSuccess = (qrResult) -> Void
    var showSucces: ShowSuccess? { get set }
}
