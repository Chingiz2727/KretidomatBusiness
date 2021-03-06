import Foundation

protocol SignatureModule: Presentable {
    typealias OnTapSubmit = (Data) -> Void
    
    var onTapSubmit: OnTapSubmit? { get set }
    typealias ShowSuccess = (qrResult, CheckoutData) -> Void
    var showSucces: ShowSuccess? { get set }
    var errorTapped: Callback? { get set }
}
