//
//  CityPickerViewDelegate.swift
//  Kreditomat
//
//  Created by kairzhan on 5/13/21.
//

import RxSwift
import UIKit

final class CityPickerViewDelegate: NSObject, UIPickerViewDelegate {
    var selectedCity = PublishSubject<City>()
    var city: [City] = [City(id: 1, name: "Алматы"),City(id: 2, name: "Астана")]

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCity.onNext(city[row])
    }

    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return city[row].name
    }
}
