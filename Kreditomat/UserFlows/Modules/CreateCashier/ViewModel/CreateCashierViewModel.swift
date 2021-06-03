//
//  CreateCashierViewModel.swift
//  Kreditomat
//
//  Created by kairzhan on 5/30/21.
//

import RxSwift

class CreateCashierViewModel: ViewModel {
    struct Input {
        let loadInfo: Observable<Void>
    }
    
    struct Output {
        let info: Observable<LoadingSequence<CashierInfo>>
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
        return .init(info: info)
    }
}
