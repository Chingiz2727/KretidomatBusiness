protocol KassOperationReportModule: Presentable {
    typealias FilterTapped = () -> Void
    typealias OnFilterSelect = (KassFilter) -> Void
    
    var filterTapped: FilterTapped? { get set }
    var onfilterSelect: OnFilterSelect? { get set }
}
