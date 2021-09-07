import RxSwift
import UIKit

final class KassOperationsViewModel: ViewModel {
    
    let apiService = assembler.resolver.resolve(ApiService.self)!
    let operationType: OperationType
    
    var arrayHeaders: [String] {
        switch operationType {
        case .PaymentHistory:
            return ["ID операции", "Дата и время", "Тип операции", "ФИО Кассира", "Наименование контрагента", "Входящий остаток", "Исходящий остаток"]
        case .BonusHistory:
            return ["ID операции", "Дата и время", "Тип операции", "ФИО Кассира", "Размер бонуса", "ИИН заемщика", "Текущий остаток"]
        }
    }
    
    init(operationType: OperationType) {
        self.operationType = operationType
    }
    
    struct Input {
        let filter: Observable<KassFilter>
        let retailPoint: Observable<String>
        let loadPoint: Observable<Void>
        let loadPdf: Observable<Void>
        let stepsValue: Observable<Int>
        let loadInfoOfTable: Observable<Void>
    }
    
    struct Output {
        let points: Observable<LoadingSequence<PointResponse>>
        let tableData: Observable<LoadingSequence<PaymentOperations>>
        let pdfUrl: Observable<LoadingSequence<PdfResponse>>
    }
    
    func transform(input: Input) -> Output {
        let pointList = input.loadPoint
            .flatMap { [unowned self] in
                return apiService.makeRequest(to: MainTarget.getActualPoints)
                    .result(PointResponse.self)
                    .asLoadingSequence()
            }.share()
        
        let table = input.retailPoint.withLatestFrom(Observable.combineLatest(input.filter,input.stepsValue)) { point, element -> Observable<LoadingSequence<PaymentOperations>> in
            return self.apiService.makeRequest(to: MainTarget.payHistory(dateFrom: element.0.firstData ?? "", dateTo: element.0.secondData ?? "", filter: element.0.periodType ?? 0, point: Int(point)!, type: self.operationType, skipValue: element.1))
                .result(PaymentOperations.self)
                .asLoadingSequence()
        }.flatMap { $0 }
        
        
        let dataTable = input.loadInfoOfTable
            .withLatestFrom(Observable.combineLatest(input.filter,input.retailPoint,input.stepsValue))
            .flatMap { [unowned self] filter, point, step -> Observable<LoadingSequence<PaymentOperations>> in
                return self.apiService.makeRequest(to: MainTarget.payHistory(dateFrom: filter.firstData ?? "", dateTo: filter.secondData ?? "", filter: filter.periodType ?? 0, point: Int(point) ?? 0, type: self.operationType, skipValue: step), stubbed: false)
                    .result(PaymentOperations.self)
                    .asLoadingSequence()
                    .share()
            }
        
        let pdfRes = input.loadPdf
            .withLatestFrom(Observable.combineLatest(input.filter, input.retailPoint, input.loadPdf)) { _, element -> Observable<PdfResponse> in
                return self.apiService.makeRequest(to: MainTarget.getPdf(dateFrom: element.0.firstData ?? "", dateTo: element.0.secondData ?? "", filter: element.0.periodType ?? 0, point: Int(element.1)!, type: self.operationType))
                    .result(PdfResponse.self)
            }.flatMap { res in
                return res.asLoadingSequence()
            }
        
        
        return .init(points: pointList, tableData: dataTable, pdfUrl: pdfRes)
    }
}
