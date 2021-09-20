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
    
    var city: [City] {
        return cityList.map { City.init(id: 1, name: $0) }
    }

    var cityList = ["Абай","Акколь","Аксай","Аксу","Актау","Актобе","Алга","Алматы","Арал","Аркалык","Арыс","Нур-Султан","Атбасар","Атырау","Аягоз","Байконыр","Балхаш","Булаево","Державинск","Ерейментау","Есик","Есиль","Жанаозен","Жанатас","Жаркент","Жезказган","Жем","Жетысай","Житикара","Зайсан","Зыряновск","Казалинск","Кандыагаш","Капшагай","Караганды","Каражал","Каратау","Каркаралинск","Каскелен","Кентау","Кокшетау","Костанай","Косшы","Кулсары","Курчатов","Кызылорда","Ленгер","Лисаковск","Макинск","Мамлютка","Павлодар","Петропавловск","Приозёрск","Риддер","Рудный","Сарань","Сарканд","Сарыагаш","Сатпаев","Семей","Сергеевка","Серебрянск","Степногорск","Степняк","Тайынша","Талгар","Талдыкорган","Тараз","Текели","Темир","Темиртау","Тобыл","Туркестан","Уральск","Усть-Каменогорск","Ушарал","Уштобе","Форт-Шевченко","Хромтау","Шардара","Шалкар","Шар","Шахтинск","Шемонаиха","Шу","Шымкент","Щучинск","Экибастуз","Эмба"]
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCity.onNext(city[row])
    }

    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return city[row].name
    }
}
