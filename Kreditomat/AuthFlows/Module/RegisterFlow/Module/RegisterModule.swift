protocol RegisterModule: Presentable {
    typealias OfferButtonTapped = () -> Void
    typealias RegisterTapped = () -> Void
    
    var offerTapped: OfferButtonTapped? { get set }
    var registerTapped: RegisterTapped? { get set }
}
