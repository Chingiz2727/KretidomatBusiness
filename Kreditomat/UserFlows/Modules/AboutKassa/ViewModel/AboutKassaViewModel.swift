import RxSwift

final class AboutKassaViewModel: ViewModel {

    struct Input {
        let typeButton: Observable<Int>
        let point: Observable<Point>
        let sum: Observable<String?>
        let succesTapped: Observable<Void>
        let pointList: Observable<Void>
    }
    
    struct Output {
        let nextTapped: Observable<LoadingSequence<ResponseStatus>>
        let loadPoint: Observable<LoadingSequence<PointResponse>>
    }

    private let apiService: ApiService
    
    init(apiService: ApiService) {
        self.apiService = apiService//MainApiServiceImpl(apiService: apiService)
    }
    
    func transform(input: Input) -> Output {
        let result = input.succesTapped
            .withLatestFrom(Observable.combineLatest(input.typeButton, input.sum, input.point))
            .flatMap { [unowned self] type, sum, point in
                return apiService.makeRequest(to: MainTarget.createCashRequest(type: type, sum: Int(sum ?? "") ?? 0, point: point.SellerID))
                    .result(ResponseStatus.self)
                    .asLoadingSequence()
            }.share()
        
        
        let pointList = input.pointList
            .flatMap { [unowned self] in
                return apiService.makeRequest(to: MainTarget.getActualPoints)
                    .result(PointResponse.self)
                    .asLoadingSequence()
            }.share()
            
        
        return .init(nextTapped: result, loadPoint: pointList)
    }
}

