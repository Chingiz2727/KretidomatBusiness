import RxSwift
import YandexMapsMobile


final class MapViewModel: ViewModel {
    
    private var searchManager: YMKSearchManager?
    private var searchSession: YMKSearchSession?
    private let disposeBag = DisposeBag()
    private let location: PublishSubject<DeliveryLocation> = .init()
    private let locationArray: PublishSubject<[DeliveryLocation]> = .init()
    
    var cameraLocationItem: ((MapPoint,Bool)->Void)?
    
    struct Input {
        let text: Observable<String>
    }
    
    struct Output {
        let locationName: Observable<DeliveryLocation>
        let locationArray: Observable<[DeliveryLocation]>
    }
    
    func transform(input: Input) -> Output {
        searchManager = YMKSearch.sharedInstance().createSearchManager(with: .combined)
        
        input.text
            .subscribe(onNext: { [unowned self] text in
                if !text.isEmpty {
                    self.searchByText(text: text)
                }
            })
            .disposed(by: disposeBag)

        cameraLocationItem = { [weak self] point, finished in
            if finished {
                self?.searchByCameraLocation(mapPoint: point)
            }
        }
        
        return .init(locationName: location, locationArray: locationArray)
    }
    
    private func searchByCameraLocation(mapPoint: MapPoint) {
        let options = YMKSearchOptions()
        options.geometry = false
        
        searchSession = searchManager?.submit(with: YMKPoint(latitude: mapPoint.latitude, longitude: mapPoint.longitude), zoom: 18, searchOptions: options, responseHandler: { [unowned self] (res, err) in
            if let name = res?.collection.children[0].obj?.name, let coordinate = res?.collection.children[0].obj?.geometry[0].point {
                let deliveryLocation = DeliveryLocation(point: MapPoint(latitude: coordinate.latitude, longitude: coordinate.longitude), name: name)
                self.location.onNext(deliveryLocation)
            }
        })
    }
    
    private func searchByText(text: String) {
        let options = YMKSearchOptions()
        options.geometry = false
        searchSession = searchManager?.submit(withText: text, geometry: .init(polyline: Constants.ShymkentPolyLine), searchOptions: options, responseHandler: { response, error in
            guard let collection = response?.collection.children else { return }
            let locationArray: [DeliveryLocation] = collection.map { object in
                let name = object.obj?.name
                let coordinate = object.obj?.geometry[0].point
                return .init(point: MapPoint(latitude: coordinate?.latitude ?? 0, longitude: coordinate?.longitude ?? 0), name: name ?? "")
            }
            self.locationArray.onNext(locationArray)
        })
    }
}
private enum Constants {
    static let ShymkentPolyLine = YMKPolyline(
        points: [
            YMKPoint(latitude: 42.271008, longitude: 69.558747),
            YMKPoint(latitude: 42.382227, longitude: 69.491084),
            YMKPoint(latitude: 42.410608, longitude: 69.636103),
            YMKPoint(latitude: 42.311006, longitude: 69.660448)
        ]
    )
}
