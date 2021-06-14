protocol KassOperationFilterModule: Presentable {
    typealias OnFilterSended = (KassFilter) -> Void
    
    var onFilterSended: OnFilterSended? { get set
        
    }
}
