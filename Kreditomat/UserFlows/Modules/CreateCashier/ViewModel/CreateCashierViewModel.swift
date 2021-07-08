//
//  CreateCashierViewModel.swift
//  Kreditomat
//
//  Created by kairzhan on 5/30/21.
//

import RxSwift

class CreateCashierViewModel: ViewModel {
    var sellerId = 0
    var sellerUserId = 0
    var pointId = 0
    struct Input {
        let loadInfo: Observable<Void>
        let blockTapped: Observable<Void>
        let loadPoints: Observable<Void>
        let attachTapped: Observable<Void>
    }
    
    struct Output {
        let info: Observable<LoadingSequence<CashierInfo>>
        let blockResponse: Observable<LoadingSequence<ResponseStatus>>
        let points: Observable<LoadingSequence<PointResponse>>
        let attachResponse: Observable<LoadingSequence<ResponseStatus>>
    }
    
    private let apiService: ApiService
    
    init(apiService: ApiService) {
        self.apiService = apiService
    }
    
    func transform(input: Input) -> Output {
        let info = input.loadInfo
            .flatMap { [unowned self] in
                (self.apiService.makeRequest(to: CashierTarget.getCashiers))
                    .result(CashierInfo.self)
                    .asLoadingSequence()
            }.share()
        let blockResponse = input.blockTapped
            .flatMap { [unowned self] in
                return apiService.makeRequest(to: CashierTarget.block(sellerId: sellerId, sellerUserId: sellerUserId, type: 2))
                                                .result(ResponseStatus.self)
                                                .asLoadingSequence()
            }.share()
        let points = input.loadPoints
            .flatMap { [unowned self] in
                return apiService.makeRequest(to: CashierTarget.getPoints)
                    .result(PointResponse.self)
                    .asLoadingSequence()
            }.share()
        
        let attachResponse = input.attachTapped
            .flatMap { [unowned self] in
                return apiService.makeRequest(to: CashierTarget.attachCashier(sellerId: pointId, sellerUserId: sellerUserId))
                    .result(ResponseStatus.self)
                    .asLoadingSequence()
            }.share()
        return .init(info: info, blockResponse: blockResponse, points: points, attachResponse: attachResponse)
    }
}
