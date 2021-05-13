//
//  EndDayPickerViewDelegate.swift
//  Kreditomat
//
//  Created by kairzhan on 5/13/21.
//

import RxSwift
import UIKit

final class EndDayPickerViewDelegate: NSObject, UIPickerViewDelegate {
    var selectedDay = PublishSubject<Day>()
    var day: [Day] = []

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedDay.onNext(day[row])
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return day[row].longName
    }
}
