//
//  MapViewController.swift
//  Kreditomat
//
//  Created by kairzhan on 5/20/21.
//

import UIKit
import GoogleMaps
import GooglePlaces
import RxSwift

class MapViewController: ViewController, ViewHolder, MapModule {
    var didAddressSelectedHandler: DidAddressSelectedHandler?
    
    typealias RootViewType = MapView
    
    let locationManager = CLLocationManager()
    private let disposeBag = DisposeBag()
    private var address = Address(lat: 0, long: 0, name: "")
    
    override func loadView() {
        view = MapView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Выберите адрес"
        checkLocationServices()
        bindView()
        rootView.mapView.delegate = self
    }
    
    // Present the Autocomplete view controller when the button is pressed.
    @objc func autocompleteClicked() {
      let autocompleteController = GMSAutocompleteViewController()
      autocompleteController.delegate = self

      // Specify the place data types to return.
        let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) | UInt(GMSPlaceField.coordinate.rawValue))
      autocompleteController.placeFields = fields

      // Specify a filter.
      let filter = GMSAutocompleteFilter()
      filter.type = .address
      filter.country = "KZ"
      autocompleteController.autocompleteFilter = filter

      // Display the autocomplete view controller.
      present(autocompleteController, animated: true, completion: nil)
    }
    
    private func bindView() {
        rootView.textField.rx.controlEvent(.allEditingEvents)
            .subscribe(onNext: { [unowned self] in
                self.autocompleteClicked()
            }).disposed(by: disposeBag)
        
        rootView.saveButton.rx.tap
            .subscribe(onNext: { [unowned self] in
                self.didAddressSelectedHandler?(address)
            }).disposed(by: disposeBag)
    }
    
    override func customBackButtonDidTap() {
        navigationController?.popViewController(animated: true)
    }
    func zoomToCamera(lat: Double, long: Double) {
        self.rootView.mapView.animate(to: GMSCameraPosition(latitude: lat, longitude: long, zoom: 14))
    }
}

extension MapViewController: GMSAutocompleteViewControllerDelegate {

  // Handle the user's selection.
  func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
    let placeLat = place.coordinate.latitude
    let placeLong = place.coordinate.longitude
        self.rootView.textField.text = place.name
        self.address = Address(lat: placeLat, long: placeLong, name: place.name ?? "")
        dismiss(animated: true, completion: nil)
    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500), execute: {
        self.zoomToCamera(lat: placeLat, long: placeLong)
        })
  }

  func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
    // TODO: handle the error.
    print("Error: ", error.localizedDescription)
  }

  // User canceled the operation.
  func wasCancelled(_ viewController: GMSAutocompleteViewController) {
    dismiss(animated: true, completion: nil)
  }

  // Turn the network activity indicator on and off again.
  func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
  }

  func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = false
  }

}

extension MapViewController: CLLocationManagerDelegate {
    
    func startTackingUserLocation() {
        guard
            let lat = self.locationManager.location?.coordinate.latitude,
            let lng = self.locationManager.location?.coordinate.longitude else { return }
        
        let camera: GMSCameraPosition = .camera(withLatitude: lat, longitude: lng, zoom: 16)
        rootView.mapView.camera = camera
        
        locationManager.startUpdatingLocation()
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    // MARK:- Location Services
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            rootView.mapView.isMyLocationEnabled = true
            rootView.mapView.settings.myLocationButton = true
            setupLocationManager()
            startTackingUserLocation()
        }
    }
}

extension MapViewController: GMSMapViewDelegate {

    func reverseGeocodeCoordinate(coordinate: CLLocationCoordinate2D) {

      let geocoder = GMSGeocoder()

      geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
        if let address = response?.firstResult() {
    
            self.rootView.textField.text = address.thoroughfare
            self.address = Address(lat: address.coordinate.latitude, long: address.coordinate.longitude, name: address.thoroughfare ?? "")

            UIView.animate(withDuration: 0.25) {
            self.view.layoutIfNeeded()
          }
        }
      }
    }
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        reverseGeocodeCoordinate(coordinate: position.target)
    }
}

