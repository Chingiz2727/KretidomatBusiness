protocol KassOperationReportModule: Presentable {
    typealias FilterTapped = () -> Void
    typealias OnFilterSelect = (KassFilter) -> Void
    typealias OpenPdf = (String) -> Void
    
    var filterTapped: FilterTapped? { get set }
    var onfilterSelect: OnFilterSelect? { get set }
    var openPdf: OpenPdf? { get set }
}
