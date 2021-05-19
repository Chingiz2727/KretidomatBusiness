import RxSwift
import UIKit


final class MenuViewController: UIViewController, ViewHolder, MenuModule {
    typealias RootViewType = MenuView
    
    var selectMenu: SelectMenu?
    
    private let disposeBag = DisposeBag()
    private let viewModel: MainMenuViewModel
    private var cabinetData: CabinetData
    let menu = Menu.allCases
    
    init(viewModel: MainMenuViewModel, info: CabinetData) {
        self.viewModel = viewModel
        self.cabinetData = info
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        
        rootView.tableView.rx.itemSelected
            .withLatestFrom(Observable.just(Menu.allCases)) { $1[$0.row] }
            .bind { [unowned self] item in
                self.selectMenu?(item, cabinetData)
            }.disposed(by: disposeBag)
        
        let output = viewModel.transform(input: .init(loadInfo: .just(())))
        
        let info = output.info.publish()
        
        info.element
            .subscribe(onNext: { [unowned self] info in
                self.cabinetData = info.Data
                self.rootView.headerView.setupData(data: info.Data)
            }).disposed(by: disposeBag)
        
        info.loading
            .bind(to: ProgressView.instance.rx.loading)
            .disposed(by: disposeBag)
        
        info.errors
            .bind(to: rx.error)
            .disposed(by: disposeBag)
        
        info.connect()
            .disposed(by: disposeBag)
    }
}
