protocol AboutKassaModule: Presentable {
    typealias NextTapped = () -> Void

    var nextTapped: NextTapped? { get set }
}
