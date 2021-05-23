protocol RegisterModule: Presentable {
    typealias OfferButtonTapped = () -> Void
    typealias RegisterTapped = () -> Void
    typealias MapTapped = () -> Void
    typealias PutAddress = (Address) -> Void
    var putAddress: PutAddress? { get set }
    
    var offerTapped: OfferButtonTapped? { get set }
    var registerTapped: RegisterTapped? { get set }
    var mapTapped: MapTapped? { get set }
}
