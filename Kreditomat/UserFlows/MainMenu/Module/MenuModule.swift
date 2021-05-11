protocol MenuModule: Presentable {
    typealias SelectMenu = (Menu) -> Void
    
    var selectMenu: SelectMenu? { get set }
}
