//
//  PointPickerViewDelegate.swift
//  Kreditomat
//
//  Created by kairzhan on 5/11/21.
//

import RxSwift
import UIKit

final class PointPickerViewDelegate: NSObject, UIPickerViewDelegate {
    var selectedPoint = PublishSubject<Point>()
    var pointName = BehaviorSubject<String>.init(value: "")
    var point: [Point] = []

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pointName.onNext(point[row].Name ?? "")
        selectedPoint.onNext(point[row])
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return point[row].Name
    }
}
