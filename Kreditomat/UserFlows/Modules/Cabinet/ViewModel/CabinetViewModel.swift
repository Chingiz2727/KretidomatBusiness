//
//  CabinetViewModel.swift
//  Kreditomat
//
//  Created by kairzhan on 5/18/21.
//

import RxSwift

final class CabinetViewModel: ViewModel {
    struct Input {
        let loadInfo: Observable<Void>
    }
    
    struct Output {
        let info: Observable<LoadingSequence<CabinetInfo>>
    }
    
    private let apiService: ApiService
    
    init(apiService: ApiService) {
        self.apiService = apiService
    }
    
    func transform(input: Input) -> Output {
        let info = input.loadInfo
            .flatMap { [unowned self] in
                (self.apiService.makeRequest(to: CabinetTarget.getInfo))
                    .result(CabinetInfo.self)
                    .asLoadingSequence()
            }.share()
        return .init(info: info)
    }
}
