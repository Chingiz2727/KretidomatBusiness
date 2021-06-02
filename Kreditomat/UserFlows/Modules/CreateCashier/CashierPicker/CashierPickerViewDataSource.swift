//
//  CashierPickerViewDataSource.swift
//  Kreditomat
//
//  Created by kairzhan on 5/24/21.
//

import UIKit

final class CashierPickerViewDataSource: NSObject, UIPickerViewDataSource {
    var cashier: [CashierData] = []

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        cashier.count
    }
}
