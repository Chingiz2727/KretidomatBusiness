//
//  CreateCashierFormViewModel.swift
//  Kreditomat
//
//  Created by kairzhan on 5/30/21.
//

import RxSwift

class CreateCashierFormViewModel: ViewModel {
    struct Input {
        let name: Observable<String?>
        let phone: Observable<String?>
        let createTapped: Observable<Void>
    }

    struct Output {
        let response: Observable<LoadingSequence<ResponseStatus>>
    }

    private let apiService: ApiService

    init(apiService: ApiService) {
        self.apiService = apiService
    }

    func transform(input: Input) -> Output {
        let response = input.createTapped
            .withLatestFrom(Observable.combineLatest(input.name, input.phone))
            .flatMap { [unowned self] name, phone in
                return apiService.makeRequest(to: CashierTarget.createCashier(name: name ?? "", email: "", phone: phone ?? ""))
                    .result(ResponseStatus.self)
                    .asLoadingSequence()
            }.share()
        return .init(response: response)
    }
}
