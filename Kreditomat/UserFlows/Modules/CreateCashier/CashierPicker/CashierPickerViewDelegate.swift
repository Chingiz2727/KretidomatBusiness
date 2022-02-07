//
//  CashierPickerViewDelegate.swift
//  Kreditomat
//
//  Created by kairzhan on 5/24/21.
//

import RxSwift
import UIKit

final class CashierPickerViewDelegate: NSObject, UIPickerViewDelegate {
    var selectedCashier = PublishSubject<CashierData?>()
    var cashier: [CashierData]? = []

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let data = cashier?[row]  {
            selectedCashier.onNext(data)
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cashier?[row].Name
    }
}
