protocol KassOperationReportModule: Presentable {
    typealias FilterTapped = () -> Void
    
    var filterTapped: FilterTapped? { get set }
}
