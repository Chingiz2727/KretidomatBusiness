import RxSwift

final class AboutKassaViewModel: ViewModel {

    struct Input {
        let typeButton: Observable<Int>
        let point: Observable<Int>
        let sum: Observable<String?>
        let succesTapped: Observable<Void>
        let pointList: Observable<Void>
        let typeButtonTapped: Observable<Void>
    }
    
    struct Output {
        let nextTapped: Observable<LoadingSequence<ResponseStatus>>
        let loadPoint: Observable<LoadingSequence<PointResponse>>
        let checkRequest: Observable<LoadingSequence<ResponseStatus>>
    }

    private let apiService: ApiService
    
    init(apiService: ApiService) {
        self.apiService = apiService//MainApiServiceImpl(apiService: apiService)
    }
    
    func transform(input: Input) -> Output {
        let result = input.succesTapped
            .withLatestFrom(Observable.combineLatest(input.typeButton, input.sum, input.point))
            .flatMap { [unowned self] type, sum, point in
                return apiService.makeRequest(to: MainTarget.createCashRequest(type: type, sum: Int(sum ?? "") ?? 0, point: point))
                    .result(ResponseStatus.self)
                    .asLoadingSequence()
            }.share()
        
        let pointList = input.pointList
            .flatMap { [unowned self] in
                return apiService.makeRequest(to: MainTarget.getActualPoints)
                    .result(PointResponse.self)
                    .asLoadingSequence()
            }.share()
        
        let checkRequest = input.typeButtonTapped
            .withLatestFrom(Observable.combineLatest(input.typeButton, input.point))
            .flatMap { [unowned self] type, point in
                return apiService.makeRequest(to: MainTarget.checkActualRequest(type: type, point: 0))
                    .result(ResponseStatus.self)
                    .asLoadingSequence()
            }.share()
        
        return .init(nextTapped: result, loadPoint: pointList, checkRequest: checkRequest)
    }
}
