//
//  CreatePointFormViewModel.swift
//  Kreditomat
//
//  Created by kairzhan on 5/13/21.
//

import RxSwift

final class CreatePointFormViewModel: ViewModel {
    
    struct Input {
        let loadDay: Observable<Void>
    }
    
    struct Output {
        let getDay: Observable<[Day]>
    }
    
    func transform(input: Input) -> Output {
        let loadDay = input.loadDay
            .flatMap { [unowned self] in
                return Observable.just(loadDays())
            }
        return .init(getDay: loadDay)
    }
    
    private func loadDays() -> [Day] {
        if let url = Bundle.main.url(forResource: "day", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let day = try decoder.decode(DayList.self, from: data)
                return day.days
            } catch let error {
                print(error)
                return []
            }
        }
        return []
    }
}
