import UIKit

class CustomAlertViewController: UIViewController, ViewHolder {

    typealias RootViewType = CustomAlertView
    var type: AlertType!
    override func loadView() {
        view = CustomAlertView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rootView.configureByType(type: type)
    }
}

enum AlertType {
    case recoverPass
    case anketoOnRequest
    case giveCredit(sum: String, fio: String)
    case getCreditPay(sum: String, fio: String)
    case blockKassir(fio: String)
    case blockPoint(name: String)
    case giveMoneyToPoint(name: String, sum: String)
    case getMoneyFromPoint(name: String, sum: String)
    case logout
    
    
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
        default:
            return nil
        }
    }
    var titleSubtitle: String? {
        switch self {
        case .recoverPass:
            return "Скоро мы с вами обязательно свяжемся"
        case .anketoOnRequest:
            return "Мы с вами обязательно свяжемся"
        case .getMoneyFromPoint(let name, _),.giveMoneyToPoint(let name, _):
            return name
        default:
            return nil
        }
    }
    var descriptionTitle: String? {
        switch self {
        case .anketoOnRequest:
            return "Возникли вопросы? \nВы можете связаться с нами:"
        case .giveMoneyToPoint:
            return "на сумму:"
        default:
            return nil
        }
    }
    var descriptionSubtitle: String? {
        switch self {
        case .anketoOnRequest:
            return "+7 (000) - 000 - 00 - 00 /nпочта - KREDITOMAT.kz"
        case .getMoneyFromPoint(_,let sum),.giveMoneyToPoint(_ , let sum):
            return "\(sum) тенге"
        default:
            return nil
        }
    }
    
}

extension UIViewController {
    
    func presentCustomAlert(type: AlertType) {
        let controller = CustomAlertViewController()
        controller.type = type
        controller.modalPresentationStyle = .overCurrentContext
        navigationController?.present(controller, animated: true, completion: nil)
    }
}
