protocol AuthStateModule: Presentable {
    typealias SignInTapped = () -> Void
    typealias SignUpTapped = () -> Void
    
    var signInTapped: SignInTapped? { get set }
    var signUpTapped: SignUpTapped? { get set }
}
