//
//  MainMenuViewModel.swift
//  Kreditomat
//
//  Created by kairzhan on 5/18/21.
//

import RxSwift

class LoadUserInfo {
    var savedInfo: Callback?
    
    private let disposeBag = DisposeBag()
    private let apiService: ApiService = assembler.resolver.resolve(ApiService.self)!
    
    func loadUserInfo() {
        apiService.makeRequest(to: CabinetTarget.getInfo)
            .result(CabinetInfo.self)
            .subscribe(onNext: { [unowned self] cabinet in
                self.saveInfo(cabinet: cabinet)
                self.savedInfo?()
            })
            .disposed(by: disposeBag)
    }
    
    private func saveInfo(cabinet: CabinetInfo) {
        UserInfoStorage.shared.save(cabinetData: cabinet.Data)
    }
}
