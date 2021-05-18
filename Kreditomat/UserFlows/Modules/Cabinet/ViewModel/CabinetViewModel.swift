//
//  CabinetViewModel.swift
//  Kreditomat
//
//  Created by kairzhan on 5/18/21.
//

import RxSwift

final class CabinetViewModel: ViewModel {
    struct Input {
    }
    
    struct Output {
    }
    
    private let apiService: ApiService
    
    init(apiService: ApiService) {
        self.apiService = apiService
    }
    
    func transform(input: Input) -> Output {
        return .init()
    }
}
