import UIKit
import RxSwift

class CustomAlertViewController: UIViewController, ViewHolder {
    typealias RootViewType = CustomAlertView
    var type: AlertType!
    
    var firstButtonAction: (()->Void)?
    var secondButtonAction: (()->Void)?
    var exitButtonAction: (()->Void)?
    
    let disposeBag = DisposeBag()
    
    override func loadView() {
        view = CustomAlertView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rootView.acceptButton.addTarget(self, action: #selector(firstTapped), for: .touchUpInside)
        rootView.declineButton.addTarget(self, action: #selector(secondTapped), for: .touchUpInside)
        rootView.configureByType(type: type)
        rootView.exitView.rx.tap
            .subscribe(onNext: { [unowned self] in
                self.dismiss(animated: true, completion: exitButtonAction)
            }).disposed(by: disposeBag)
    }
    
    @objc private func firstTapped() {
        firstButtonAction?()
    }
    
    @objc private func secondTapped() {
        secondButtonAction?()
    }
}

enum AlertType {
    case recoverPass
    case anketoOnRequest
    case giveCredit(sum: String, fio: String)
    case getCreditPay(sum: String, fio: String)
    case blockKassir(fio: String)
    case unblockKassir(fio: String)
    case blockPoint(name: String)
    case giveMoneyToPoint(name: String, sum: String)
    case getMoneyFromPoint(name: String, sum: String)
    case logout
    case changePass
    case applicationGiveMoney
    case applicationGetMoney
    case checkActualApplication(title: String)
    
    var title: String? {
        switch self {
        case .recoverPass:
            return "Ваша заявка на восстановление пароля принята."
        case .anketoOnRequest:
            return "Ваша анкета будет рассмотрена в ближайщее время."
        case .giveMoneyToPoint:
            return "Вы хотите пополнить денежными средставми точку:"
        case .getMoneyFromPoint:
            return "Вы хотите изъять денежные средстав из точки:"
        case .blockKassir:
            return "Вы уверены что хотите заблокировать кассира?"
        case .unblockKassir:
            return "Вы уверены что хотите разблокировать кассира?"
        case .blockPoint:
            return "Вы уверены что хотите заблокировать точку полученя/погашения:"
        case .logout:
            return "Вы уверены что хотите выйти с приложения KREDITOMAT.KZ"
        case .getCreditPay:
            return "Вы принимаете оплату микрокредита от заемщика:"
        case .giveCredit:
            return "Вы выдаете денежные средства на сумму:"
        case .changePass:
            return "Пароль успешно изменен"
        case .applicationGiveMoney:
            return "Заявка на пополнение находится на рассмотрении"
        case .applicationGetMoney:
            return "Заявка на изьятие находится на рассмотрении"
        case let .checkActualApplication(title):
            return title
            
       
        }
    }
    
    var titleSubtitle: String? {
        switch self {
        case .recoverPass:
            return "Скоро мы с вами обязательно свяжемся"
        case .anketoOnRequest, .checkActualApplication:
            return "Мы с вами обязательно свяжемся"
        case .getMoneyFromPoint(let name, _),.giveMoneyToPoint(let name, _):
            return name
        case .blockKassir(let fio):
            return fio
        case .unblockKassir(let fio):
            return fio
        case .blockPoint(let name):
            return name
        case .getCreditPay(_,let fio):
            return fio
        case  .giveCredit(let sum, _):
            return "\(sum) тенге"
        case .applicationGetMoney, .applicationGiveMoney:
            return "Мы с вами обязательно свяжемся"
        
        default:
            return nil
        }
    }
    
    var descriptionTitle: String? {
        switch self {
        case .anketoOnRequest, .recoverPass,.changePass, .applicationGetMoney, .applicationGiveMoney, .checkActualApplication:
            return "Возникли вопросы? \nВы можете связаться с нами:"
        case .giveMoneyToPoint:
            return "на сумму:"
        case .logout:
            return "Прежде чем выйти из приложения, просим запомнить предоставленный Вам пароль или замените его на новый"
        case .getCreditPay:
            return "на сумму:"
        case  .giveCredit:
            return "Заемщик:"
        default:
            return nil
        }
    }
    
    var descriptionSubtitle: String? {
        switch self {
        case .anketoOnRequest, .recoverPass, .applicationGetMoney, .applicationGiveMoney, .checkActualApplication:
            return "+7 (000) - 000 - 00 - 00 \nпочта - KREDITOMAT.kz"
        case .getMoneyFromPoint(_,let sum),.giveMoneyToPoint(_ , let sum):
            return "\(sum) тенге"
        case .getCreditPay(let sum, _):
            return "\(sum) тенге"
        case .giveCredit(_, let fio):
            return fio
        default:
            return nil
        }
    }
    
    var firstButtonHidden: Bool {
        switch self {
        case .anketoOnRequest, .recoverPass,.changePass, .applicationGetMoney, .applicationGiveMoney, .checkActualApplication:
            return true
        default:
            return false
        }
    }
    
    var secondButtonHidden: Bool {
        switch self {
        case .giveMoneyToPoint,.getMoneyFromPoint, .getCreditPay,.blockKassir, .unblockKassir, .blockPoint, .logout, .giveCredit:
            return false
        default:
            return true
        }
    }
}

extension UIViewController {
    
    func presentCustomAlert(type: AlertType, firstButtonAction: Callback? = nil, secondButtonAction: Callback? = nil, ondismiss: Callback? = nil) {
        let controller = CustomAlertViewController()
        controller.type = type
        controller.firstButtonAction = { firstButtonAction?() }
        controller.secondButtonAction = { secondButtonAction?() }
        controller.exitButtonAction = { ondismiss?() }
        controller.modalPresentationStyle = .overCurrentContext
        navigationController?.present(controller, animated: true, completion: ondismiss)
    }
}
