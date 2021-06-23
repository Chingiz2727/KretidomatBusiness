//
//  CreatePointViewModel.swift
//  Kreditomat
//
//  Created by kairzhan on 6/15/21.
//

import RxSwift

class CreatePointViewModel: ViewModel {
    var sellerId = 0
    var sellerUserId = 0
    struct Input {
        let loadPoints: Observable<Void>
        let pointBlock: Observable<Void>
        let cashierBlock: Observable<Void>
    }
    
    struct Output {
        let points: Observable<LoadingSequence<PointResponse>>
        let pointBlockRes: Observable<LoadingSequence<ResponseStatus>>
        let cashierBlockRes: Observable<LoadingSequence<ResponseStatus>>
    }
    
    private let apiService: ApiService
    
    init(apiService: ApiService) {
        self.apiService = apiService
    }
    
    func transform(input: Input) -> Output {
        let points = input.loadPoints
            .flatMap { [unowned self] in
                return apiService.makeRequest(to: CashierTarget.getPoints)
                    .result(PointResponse.self)
                    .asLoadingSequence()
            }.share()
        let pointBlockRes = input.pointBlock
            .flatMap { [unowned self] in
                return apiService.makeRequest(to: CashierTarget.block(sellerId: sellerId, sellerUserId: 0, type: 1))
                    .result(ResponseStatus.self)
                    .asLoadingSequence()
            }.share()
        let cashierBlockRes = input.cashierBlock
            .flatMap { [unowned self] in
                return apiService.makeRequest(to: CashierTarget.block(sellerId: 0, sellerUserId: sellerUserId, type: 2))
                    .result(ResponseStatus.self)
                    .asLoadingSequence()
            }.share()
        return .init(points: points, pointBlockRes: pointBlockRes, cashierBlockRes: cashierBlockRes)
    }
}
