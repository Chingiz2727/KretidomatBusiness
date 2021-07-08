//
//  CreatePointFormViewModel.swift
//  Kreditomat
//
//  Created by kairzhan on 5/13/21.
//

import RxSwift

final class CreatePointFormViewModel: ViewModel {
    
    var name: String = ""
    var phone: String = ""
    var email: String = ""
    var city: String = ""
    var address: String = ""
    var house: String = ""
    var apartments: String = ""
    var bin: String = ""
    var lat: Double = 0.0
    var long: Double = 0.0
    var workingTime: String = ""
    
    struct Input {
        let loadDay: Observable<Void>
        let createPointTapped: Observable<Void>
        
    }
    
    struct Output {
        let getDay: Observable<[Day]>
        let createPoint: Observable<LoadingSequence<ResponseStatus>>
        
    }
    
    private let apiService: ApiService
    
    init(apiService: ApiService) {
        self.apiService = apiService
    }
    
    func transform(input: Input) -> Output {
        let loadDay = input.loadDay
            .flatMap { [unowned self] in
                return Observable.just(loadDays())
            }
        
        let point = input.createPointTapped
            .flatMap { [unowned self] _ in
                apiService.makeRequest(to: MainTarget.registerPoint(name: name, email: email, city: city, address: address, house: house, apartments: apartments, bin: bin, posLat: String(lat), posLng: String(long), workingTime: workingTime))
                    .result(ResponseStatus.self)
                    .asLoadingSequence()
            }.share()
        
        return .init(getDay: loadDay, createPoint: point)
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
