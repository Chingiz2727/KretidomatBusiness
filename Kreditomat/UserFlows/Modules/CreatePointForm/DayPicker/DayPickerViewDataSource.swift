//
//  DayPickerViewDataSource.swift
//  Kreditomat
//
//  Created by kairzhan on 5/13/21.
//

import UIKit

final class DayPickerViewDataSource: NSObject, UIPickerViewDataSource {
    var day: [Day] = []

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        day.count
    }
}

