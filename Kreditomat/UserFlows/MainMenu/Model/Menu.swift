//
//  Menu.swift
//  Kreditomat
//
//  Created by Чингиз Куандык on 11.05.2021.
//

import Foundation
import UIKit

enum Menu: CaseIterable {
    
    case mainPage
    case getCredit
    case clearCredit
    case aboutCredit
    case aboutBonus
    case aboutKassa
    case createPoint
    case changePassWord
    case share
    case logout
    
    var title: String {
        switch self {
        case  .mainPage:
            return "Личный кабинет"
        case .getCredit:
            return "Выдача микрокредита"
        case .clearCredit:
            return "Погашение микрокредита"
        case .aboutCredit:
            return "Отчет по кассовым операциям"
        case .aboutBonus:
            return "Отчет по бонусам"
        case .aboutKassa:
            return "Кассовые операции"
        case .createPoint:
            return "Создать точку"
        case .changePassWord:
            return "Изменить пароль"
        case .logout:
            return "Выход"
        case .share:
            return "Поделиться"
        }
    }
    
    
    var logoImg: UIImage {
        switch self {
        case .mainPage:
            return #imageLiteral(resourceName: "logout")
        case .getCredit:
            return #imageLiteral(resourceName: "kredit")
        case .clearCredit:
            return #imageLiteral(resourceName: "pogashenie")
        case .aboutCredit:
            return #imageLiteral(resourceName: "otchet")
        case .aboutBonus:
            return #imageLiteral(resourceName: "otchet")
        case .aboutKassa:
            return #imageLiteral(resourceName: "kassa")
        case .createPoint:
            return #imageLiteral(resourceName: "kreditPlace")
        case .changePassWord:
            return #imageLiteral(resourceName: "changePass")
        case .share:
            return #imageLiteral(resourceName: "share")
        case .logout:
            return #imageLiteral(resourceName: "lock")
        }
    }
}
