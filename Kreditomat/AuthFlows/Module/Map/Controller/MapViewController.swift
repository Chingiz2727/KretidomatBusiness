//
//  MapViewController.swift
//  Kreditomat
//
//  Created by kairzhan on 5/20/21.
//

import UIKit
import CoreLocation
import YandexMapsMobile
import RxSwift

class MapViewController: ViewController, ViewHolder, MapModule {
    var didAddressSelectedHandler: DidAddressSelectedHandler?
    
    typealias RootViewType = MapView
    
    let locationManager = CLLocationManager()
    private let deliveryLocationObject: PublishSubject<DeliveryLocation> = .init()
    
    private let viewModel = MapViewModel()
    private let disposeBag = DisposeBag()
    private var address = Address(lat: 0, long: 0, name: "")
    
    override func loadView() {
        view = MapView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        let mapKit = YMKMapKit.sharedInstance()
        let userLocationLayer = mapKit.createUserLocationLayer(with: rootView.mapView.mapWindow)
        userLocationLayer.setVisibleWithOn(true)
        userLocationLayer.isHeadingEnabled = true
        
        title = "Выберите адрес"
        bindView()
    }
    
    private func bindView() {
        let output = viewModel.transform(input: .init(text: rootView.textField.rx.text.unwrap()))
        
        
        let locationArr = output.locationArray.share()
        
        locationArr.bind(to: rootView.tableView.rx.items(UITableViewCell.self)) { _, model ,cell in
            cell.textLabel?.text = model.name
        }
        .disposed(by: disposeBag)
        
        rootView.textField.rx.controlEvent(.allEditingEvents)
            .subscribe(onNext: { [unowned self] in
                //                self.autocompleteClicked()
            }).disposed(by: disposeBag)
        
        let location = output.locationName.publish()
        location.subscribe(onNext: { [unowned self] location in
            self.rootView.textField.text = location.name
            self.address = Address(lat: location.point.latitude, long: location.point.longitude, name: location.name)
        }).disposed(by: disposeBag)
        
        location.connect()
            .disposed(by: disposeBag)
        
        rootView.saveButton.rx.tap
            .subscribe(onNext: { [unowned self] in
                self.didAddressSelectedHandler?(address)
            }).disposed(by: disposeBag)
        
        rootView.textField.rx.text.unwrap()
            .subscribe(onNext: { [unowned self] text in
                self.rootView.tableView.isHidden = text.isEmpty
            })
            .disposed(by: disposeBag)
        
        rootView.tableView.rx.itemSelected
            .withLatestFrom(locationArr) { (index, array) -> DeliveryLocation in
                return array[index.row]
            }.subscribe(onNext: { [unowned self] location in
                self.selectLocationAtList(location: location)
                self.address = Address(lat: location.point.latitude, long: location.point.longitude, name: location.name)
                self.moveToMyLocation(lat: location.point.latitude, lon: location.point.longitude)
            })
            .disposed(by: disposeBag)
        rootView.mapView.mapWindow.map.addCameraListener(with: self)
        
        rootView.locationButton.rx.tap
            .subscribe(onNext: { [unowned self] in
                if let location = self.locationManager.location?.coordinate {
                    self.moveToMyLocation(lat: location.latitude, lon: location.longitude)
                }
            }).disposed(by: disposeBag)
    }
    
    private func selectLocationAtList(location: DeliveryLocation) {
        rootView.textField.text = location.name
        self.rootView.tableView.isHidden =  true
        address = Address(lat: location.point.latitude, long: location.point.longitude, name: location.name)
        deliveryLocationObject.onNext(location)
    }
    
    private func moveToMyLocation(lat: Double, lon: Double) {
        let mapWindow = rootView.mapView.mapWindow.map
        mapWindow.move(with: .init(target: .init(latitude: lat, longitude: lon), zoom: 14, azimuth: 0, tilt: 0), animationType: YMKAnimation.init(type: .linear, duration: 0.4), cameraCallback: nil)
    }
    
    override func customBackButtonDidTap() {
        navigationController?.popViewController(animated: true)
    }
}

extension MapViewController: YMKMapCameraListener {
    func onCameraPositionChanged(with map: YMKMap, cameraPosition: YMKCameraPosition, cameraUpdateReason: YMKCameraUpdateReason, finished: Bool) {
        viewModel.cameraLocationItem?(.init(latitude: cameraPosition.target.latitude, longitude: cameraPosition.target.longitude),finished)
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard let coordinate = manager.location?.coordinate else {
            return
        }
        moveToMyLocation(lat: coordinate.latitude, lon: coordinate.longitude)
    }
}
