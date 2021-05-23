protocol AuthUserModule: Presentable {
    typealias AuthButtonTap = () -> Void
    typealias ResetButtonTap = () -> Void
    var authTapped: AuthButtonTap? { get set }
    var resetTapped: ResetButtonTap? { get set }
    
}
