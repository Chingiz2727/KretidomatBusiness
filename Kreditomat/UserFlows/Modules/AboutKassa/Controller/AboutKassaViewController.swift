import UIKit
import RxSwift

final class AboutKassaViewController: ViewController, ViewHolder, AboutKassaModule {
    
    typealias RootViewType = AboutKassaView
    
    var nextTapped: NextTapped?
    
    private let viewModel: AboutKassaViewModel
    private var pointPickerDelegate: PointPickerViewDelegate
    private var pointPickerDataSource: PointPickerViewDataSource
    private let pointPickerView = UIPickerView()
    private let disposeBag = DisposeBag()
    private let buttontapped: PublishSubject<Void> = .init()
    init(viewModel: AboutKassaViewModel) {
        self.viewModel = viewModel
        self.pointPickerDataSource = PointPickerViewDataSource()
        self.pointPickerDelegate = PointPickerViewDelegate()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = AboutKassaView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setupPointPickerView()
        navigationController?.navigationBar.layer.addShadow()
        title = "Кассовые операции"
    }
    
    private func bindViewModel() {
        
        let output = viewModel.transform(
            input: .init(typeButton: rootView.selectTag,
                         point: .just(.init(SellerID: 3, Phone: "", Name: "", City: "", Address: "", House: "", Apartments: "", BIN: "", CashierID: nil, CashierName: "", CashierPhone: "", BonusSum: nil)),
                         sum: rootView.amountOperationView.amountTextField.rx.text.asObservable(),
                         succesTapped: rootView.accessButton.rx.tap.asObservable(),
                         pointList: .just(())))
        
        let result = output.nextTapped.publish()
        
        result.element
            .subscribe(onNext: { [unowned self] result in
                if result.Success == true {
                    self.presentCustomAlert(type: .giveMoneyToPoint(name: "", sum: rootView.amountOperationView.amountTextField.allText))
                } else {
                    self.showErrorInAlert(text: result.Message)
                }
            }).disposed(by: disposeBag)
        
        result.errors
            .bind(to: rx.error)
            .disposed(by: disposeBag)

        pointPickerDelegate.selectedPoint.onNext(.init(SellerID: 3, Phone: "", Name: "", City: "", Address: "", House: "", Apartments: "", BIN: "", CashierID: nil, CashierName: "", CashierPhone: "", BonusSum: nil))
        
        result.connect()
            .disposed(by: disposeBag)
        
        let points = output.loadPoint.publish()
        
        points.subscribe(onNext: { [unowned self] point in
            point.result.map { [weak self] p in
                self?.pointPickerDataSource.point = p.element?.Data ?? []
                self?.pointPickerDelegate.point = p.element?.Data ?? []
            }
        }).disposed(by: disposeBag)
        
        points.connect()
            .disposed(by: disposeBag)
        
        pointPickerDelegate.selectedPoint
            .subscribe(onNext: { [unowned self] point in
                self.rootView.pointListTextField.textField.text = point.Name
            }).disposed(by: disposeBag)
        
        rootView.refillButton.rx.tap
            .subscribe(onNext: { [unowned self] in
                self.rootView.configureButton(selected: true)
            }).disposed(by: disposeBag)
        
        rootView.withdrawalButton.rx.tap
            .subscribe(onNext: { [unowned self] in
                self.rootView.configureButton(selected: false)
            }).disposed(by: disposeBag)
        rootView.accessButton.rx.tap.subscribe(onNext: { [unowned self] tap in
            self.buttontapped.onNext(())
        } )
            .disposed(by: disposeBag)
    }
    
    private func setupPointPickerView() {
        rootView.tableView.registerClassForCell(UITableViewCell.self)
        pointPickerView.delegate = pointPickerDelegate
        pointPickerView.dataSource = pointPickerDataSource
        rootView.pointListTextField.textField.inputView = pointPickerView
    }
    
    override func customBackButtonDidTap() {
        navigationController?.popViewController(animated: true)
    }
}
