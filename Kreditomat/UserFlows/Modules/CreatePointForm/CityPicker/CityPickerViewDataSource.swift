//
//  CityPickerViewDataSource.swift
//  Kreditomat
//
//  Created by kairzhan on 5/13/21.
//

import UIKit

final class CityPickerViewDataSource: NSObject, UIPickerViewDataSource {
    var city: [City] = [City(id: 1, name: "Алматы"),City(id: 2, name: "Астана")]

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        city.count
    }
}
