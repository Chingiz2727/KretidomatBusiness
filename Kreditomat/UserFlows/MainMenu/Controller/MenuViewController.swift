import RxSwift
import UIKit


final class MenuViewController: UIViewController, ViewHolder, MenuModule {
    typealias RootViewType = MenuView
    
    var selectMenu: SelectMenu?
    
    private let disposeBag = DisposeBag()
    private let menu = UserInfoStorage.shared.menu
    private let userInfo = assembler.resolver.resolve(LoadUserInfo.self)

    override func loadView() {
        view = MenuView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        userInfo?.savedInfo = { [weak self] in
            self?.rootView.headerView.setupData()
        }
        navigationController?.navigationBar.layer.addShadow()
        title = "Главная"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    private func bindViewModel() {
        Observable.just(menu)
            .bind(to: rootView.tableView.rx.items(UITableViewCell.self)) { _, model, cell in
                cell.textLabel?.text = model.title
                cell.textLabel?.font = .regular16
                cell.imageView?.image = model.logoImg
                cell.imageView?.contentMode = .scaleAspectFit
                cell.imageView?.snp.makeConstraints { make in
                    make.size.equalTo(16)
                    make.centerY.equalToSuperview()
                    make.leading.equalToSuperview().inset(12)
                }
                cell.selectionStyle = .none
                cell.textLabel?.snp.makeConstraints { make in
                    make.leading.equalTo(cell.imageView!.snp.trailing).offset(20)
                    make.centerY.equalToSuperview()
                }
            }
            .disposed(by: disposeBag)
        
        rootView.tableView.rx.itemSelected
            .withLatestFrom(Observable.just(menu)) { $1[$0.row] }
            .bind { [unowned self] item in
                if item == .logout {
                    presentCustomAlert(type: .logout, firstButtonAction: { selectMenu?(item) }, secondButtonAction: { self.dismiss(animated: true, completion: nil)} )
                } else {
                    self.selectMenu?(item)
                }
            }.disposed(by: disposeBag)
        
    }
}
