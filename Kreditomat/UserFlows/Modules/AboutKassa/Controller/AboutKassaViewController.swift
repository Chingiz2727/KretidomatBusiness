import UIKit
import RxSwift

final class AboutKassaViewController: ViewController, ViewHolder, AboutKassaModule {
    
    typealias RootViewType = AboutKassaView
    
    var nextTapped: NextTapped?
    
    private let viewModel: AboutKassaViewModel
    private let pointPickerView = UIPickerView()
    private let disposeBag = DisposeBag()
    private let buttontapped: PublishSubject<Void> = .init()
    private let pointsSelledId = PublishSubject<Int>()
    private var points: [Point] = []
    
    init(viewModel: AboutKassaViewModel) {
        self.viewModel = viewModel
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
                         point: pointsSelledId,
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
        
        result.connect()
            .disposed(by: disposeBag)
        
        let points = output.loadPoint.publish()
        
        points.element
            .subscribe(onNext: { [unowned self] point in
                self.points = point.Data
                self.pointPickerView.reloadAllComponents()
            }).disposed(by: disposeBag)
        
        points.connect()
            .disposed(by: disposeBag)
        
        
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
        pointPickerView.delegate = self
        pointPickerView.dataSource = self
        rootView.pointListTextField.textField.inputView = pointPickerView
    }
    
    override func customBackButtonDidTap() {
        navigationController?.popViewController(animated: true)
    }
}

extension AboutKassaViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return points.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let pointId = points[row].SellerID ?? 0
        rootView.pointListTextField.textField.text = points[row].Name ?? ""
        pointsSelledId.onNext(pointId)
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return points[row].Name
    }
}
