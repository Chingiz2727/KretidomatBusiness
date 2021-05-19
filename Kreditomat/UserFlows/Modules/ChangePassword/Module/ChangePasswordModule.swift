protocol ChangePasswordModule: Presentable {
    typealias ChangePassTapped = () -> Void
    typealias ResetPassTapped = () -> Void
    
    var changePasTapped: ChangePassTapped? { get set }
    var resetPasTapped: ResetPassTapped? { get set }
}
