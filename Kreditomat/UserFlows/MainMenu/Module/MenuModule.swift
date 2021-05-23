protocol MenuModule: Presentable {
    typealias SelectMenu = (Menu, CabinetData) -> Void
    
    var selectMenu: SelectMenu? { get set }
}
