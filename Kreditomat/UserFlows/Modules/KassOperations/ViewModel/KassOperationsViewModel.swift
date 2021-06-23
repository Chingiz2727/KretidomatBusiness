import RxSwift
import UIKit

final class KassOperationsViewModel: ViewModel {
    
    let apiService = assembler.resolver.resolve(ApiService.self)!
    let operationType: OperationType
    
    init(operationType: OperationType) {
        self.operationType = operationType
    }
    
    struct Input {
        let filter: Observable<KassFilter>
        let retailPoint: Observable<String>
        let loadPoint: Observable<Void>
        let stepsValue: Observable<Int>
    }
    
    struct Output {
        let points: Observable<LoadingSequence<PointResponse>>
        let tableData: Observable<LoadingSequence<PaymentOperations>>
    }
    
    func transform(input: Input) -> Output {
        let pointList = input.loadPoint
            .flatMap { [unowned self] in
                return apiService.makeRequest(to: MainTarget.getActualPoints)
                    .result(PointResponse.self)
                    .asLoadingSequence()
            }.share()
        
        let dataTable = Observable.combineLatest(input.filter,input.retailPoint, input.stepsValue)
            .flatMap { [unowned self] filter, point, step  -> Observable<LoadingSequence<PaymentOperations>> in
                return apiService.makeRequest(to: MainTarget.payHistory(dateFrom: filter.firstData ?? "", dateTo: filter.secondData ?? "", filter: filter.periodType ?? 0, point: Int(point)!, type: self.operationType, skipValue: step), stubbed: false)
                    .result(PaymentOperations.self)
                    .asLoadingSequence()
                
            }.share()
        
        
        return .init(points: pointList, tableData: dataTable)
    }
}
