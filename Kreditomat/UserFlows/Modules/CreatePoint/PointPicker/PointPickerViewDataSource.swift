//
//  PointPickerViewDataSource.swift
//  Kreditomat
//
//  Created by kairzhan on 5/11/21.
//

import UIKit

final class PointPickerViewDataSource: NSObject, UIPickerViewDataSource {
    var point: [Point] = []

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        point.count
    }
}
