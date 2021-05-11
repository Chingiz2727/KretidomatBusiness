import RxSwift
import UIKit


final class MenuViewController: UIViewController, ViewHolder, MenuModule {
    typealias RootViewType = MenuView
    
    var selectMenu: SelectMenu?
    
    private let disposeBag = DisposeBag()
    let menu = Menu.allCases
    
    override func loadView() {
        view = MenuView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    private func bindViewModel() {
        Observable.just(menu)
            .bind(to: rootView.tableView.rx.items(UITableViewCell.self)) { _, model, cell in
                cell.textLabel?.text = model.title
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
    }
}
