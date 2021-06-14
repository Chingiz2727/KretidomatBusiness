//
//  CameraViewModel.swift
//  Kreditomat
//
//  Created by kairzhan on 5/21/21.
//

import RxSwift

final class CameraViewModel: ViewModel {
    
    var clientId = 0
    var creditId = 0
    
    struct Input {
        let clearTapped: Observable<Void>
    }
    
    struct Output {
        let response: Observable<LoadingSequence<ResponseStatus>>
    }
    
    private let apiService: ApiService
    
    init(apiService: ApiService) {
        self.apiService = apiService
    }
    
    func transform(input: Input) -> Output {
        let clear = input.clearTapped
            .flatMap { [unowned self] in
                self.apiService.makeRequest(to: CreditTarget.clearCredit(ClientID: clientId, CreditID: creditId))
                    .result(ResponseStatus.self)
            }.asLoadingSequence()
        return .init(response: clear)
    }
}
