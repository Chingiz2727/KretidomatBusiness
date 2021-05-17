protocol ResetPasswordModule: Presentable {
    typealias ResetTapped = () -> Void
    
    var resetTapped: ResetTapped? { get set }
}
