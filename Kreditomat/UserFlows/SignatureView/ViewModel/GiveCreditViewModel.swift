//
//  GiveCreditViewModel.swift
//  Kreditomat
//
//  Created by kairzhan on 5/24/21.
//

import RxSwift

final class GiveCreditViewModel: ViewModel {
    
    var clientId = 0
    var creditId = 0
    var sig = ""
    
    struct Input {
        let giveTapped: Observable<Void>
    }
    
    struct Output {
        let response: Observable<LoadingSequence<ResponseStatus>>
    }
    
    private let apiService: ApiService
    
    init(apiService: ApiService) {
        self.apiService = apiService
    }
    
    func transform(input: Input) -> Output {
        let give = input.giveTapped
            .flatMap { [unowned self] in
                self.apiService.makeRequest(to: CreditTarget.getCredit(ClientID: clientId, CreditID: creditId, Signature: sig))
                    .result(ResponseStatus.self)
            }.asLoadingSequence()
        return .init(response: give)
    }
}
