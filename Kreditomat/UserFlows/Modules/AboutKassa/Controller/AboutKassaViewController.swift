import UIKit
import RxSwift

final class AboutKassaViewController: ViewController, ViewHolder, AboutKassaModule {
    
    typealias RootViewType = AboutKassaView
    
    var nextTapped: NextTapped?
    
    private let viewModel: AboutKassaViewModel
    private let pointPickerView = UIPickerView()
    private let disposeBag = DisposeBag()
    private let buttontapped: PublishSubject<Void> = .init()
    private let typeButtonTapped: PublishSubject<Void> = .init()
    private let makeRefillActioin = PublishSubject<Void>()
    private let makeWithAction = PublishSubject<Void>()
    
    private let pointsSelledId = BehaviorSubject<Int>.init(value: 0)
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
                         succesTapped: buttontapped,
                         pointList: .just(()),
                         typeButtonTapped: typeButtonTapped)
            
        )
        
        let result = output.nextTapped.publish()
        
        result.element
            .subscribe(onNext: { [unowned self] result in
                if result.Success == true {
                    self.showSuccessAlert {
                        print(result.Message)
                    }
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
                self.typeButtonTapped.onNext(())
            }).disposed(by: disposeBag)
        
        rootView.withdrawalButton.rx.tap
            .subscribe(onNext: { [unowned self] in
                self.rootView.configureButton(selected: false)
                self.typeButtonTapped.onNext(())
            }).disposed(by: disposeBag)
        
        let check = output.checkRequest.publish()
        check.element
            .subscribe(onNext: { [ unowned self] res in
                if res.Success == true {
                    checkSelectTag()
                } else {
                    self.presentCustomAlert(type: .checkActualApplication(title: res.Message))
                }
            }).disposed(by: disposeBag)
        
        check.errors
            .bind(to: rx.error)
            .disposed(by: disposeBag)
        
        check.connect()
            .disposed(by: disposeBag)
      
        
        rootView.pointListTextField.textField.rx.controlEvent(.editingDidBegin)
            .withLatestFrom(pointsSelledId)
            .subscribe(onNext: { [unowned self] point in
                if point == 0 {
                    let pointId = self.points.first?.SellerID ?? 0
                    rootView.pointListTextField.textField.text = self.points.first?.Name ?? ""
                    self.pointsSelledId.onNext(pointId)
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func checkSelectTag() {
        rootView.accessButton.rx.tap
            .withLatestFrom(rootView.selectTag)
            .subscribe(onNext: { [unowned self] tag in
                guard let text = self.rootView.amountOperationView.amountTextField.text else { return }
                var number = 0
                number = Int(text) ?? 0
                if number > 1000000 || number < 10000 {
                    self.showErrorInAlert(text: "Минимальный порог операций \nот 10 000 тг до 1 000 000 тг")
                } else {
                    if tag == 1 {
                        self.presentCustomAlert(type: .giveMoneyToPoint(name: rootView.pointListTextField.textField.text ?? "Name", sum: String(number))) {
                        
                            self.dismiss(animated: true) {
                                self.buttontapped.onNext(())
                                self.presentCustomAlert(type: .applicationGiveMoney)
                            }
                        } secondButtonAction: {
                            self.dismiss(animated: true, completion: nil)
                        }
                        //refill
                    } else {
                        //withdrawwl
                        self.presentCustomAlert(type: .getMoneyFromPoint(name: rootView.pointListTextField.textField.text ?? "Name", sum: rootView.amountOperationView.amountTextField.text ?? "0")) {
                            //                        self.dismiss(animated: true, completion: nil)
                            self.dismiss(animated: true) {
                                self.buttontapped.onNext(())
                                self.presentCustomAlert(type: .applicationGetMoney)
                            }
                        } secondButtonAction: {
                            self.dismiss(animated: true, completion: nil)
                        }
                    }
                    
                }
            })
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
