//
//  CabinetViewModel.swift
//  Kreditomat
//
//  Created by kairzhan on 5/18/21.
//

import RxSwift

final class CabinetViewModel: ViewModel {
    struct Input {
        let userInfo: Observable<Void>
    }
    
    struct Output {
        let loadUserInfo: Observable<LoadingSequence<CabinetInfo>>
    }
    
    private let apiService: ApiService
    
    init(apiService: ApiService) {
        self.apiService = apiService
    }
    
    func transform(input: Input) -> Output {
        
        let loadUserInfoRes = input.userInfo
            .flatMap { [unowned self] in
                return apiService.makeRequest(to: CabinetTarget.getInfo)
                    .result(CabinetInfo.self)
                    .asLoadingSequence()
            }.share()
        
        return .init(loadUserInfo: loadUserInfoRes)
    }
}



