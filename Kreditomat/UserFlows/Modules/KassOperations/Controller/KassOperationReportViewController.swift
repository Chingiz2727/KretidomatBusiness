import RxSwift
import SpreadsheetView
import PDFReader
import UIKit

class KassOperationReportViewController: ViewController, KassOperationReportModule, ViewHolder {
    var openPdf: OpenPdf?
    
    var onfilterSelect: OnFilterSelect?
    
    typealias RootViewType = KassOperationReportView
    var filterTapped: FilterTapped?
    private let disposeBag = DisposeBag()
    var viewModel: KassOperationsViewModel!
    private let filter = PublishSubject<KassFilter>()
    private let retailPoint = BehaviorSubject<String>(value: "0")
    private let stepsValue = 10
    private let skipValue: BehaviorSubject<Int> = .init(value: 0)
    private let pickerView = UIPickerView()
    private let operationTitle: [String] = ["ID операции", "Дата и время", "Тип операции", "ФИО Кассира", "Текущий остаток"]
    private var points: [Point] = []
    private var operations: PaymentOperations?
    private var loadData = PublishSubject<Void>()
    private var kassSelected : BehaviorSubject<Bool> = .init(value: true)
    
    override func loadView() {
        view = KassOperationReportView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rootView.dataTable.dataSource = self
        rootView.calendarButton.rx.tap
            .subscribe(onNext: { [unowned self] in
                self.filterTapped?()
            }).disposed(by: disposeBag)
        switch viewModel.operationType {
        case .PaymentHistory:
            rootView.headerView.titleLabel.text = "Отчет по кассовым операциям"
            title = "Отчет по кассовым операциям"
        case .BonusHistory:
            rootView.headerView.titleLabel.text = "Отчет по Бонусам"
            title = "Отчет по Бонусам"
        }
        navigationController?.navigationBar.layer.addShadow()
        
        bindViewModel()
    }
    
    private func bindViewModel() {
        let output = viewModel.transform(input: .init(filter: filter, retailPoint: retailPoint, loadPoint: .just(()), loadPdf: rootView.headerView.downloadButton.rx.tap.asObservable(), stepsValue: skipValue, loadInfoOfTable: loadData))
        
        let points = output.points.publish()
        points.element
            .subscribe(onNext: { [unowned self] points in
                self.points = points.Data
                self.pickerView.reloadAllComponents()
            })
            .disposed(by: disposeBag)
        
        points.connect()
            .disposed(by: disposeBag)
        
        let history = output.tableData.publish()
        
        history.element
            .subscribe(onNext: { [unowned self] data in
                
                DispatchQueue.main.async {
                    self.operations = data
                    self.rootView.dataTable.reloadData()
                    self.rootView.dataTable.reloadInputViews()
                    self.rootView.setView(data: data)
                }
            })
            .disposed(by: disposeBag)
        history.connect()
            .disposed(by: disposeBag)
        self.retailPoint.onNext("0")
        
        pickerView.dataSource = self
        pickerView.delegate = self
        rootView.selectContainer.textField.inputView = pickerView
        
        onfilterSelect = { [unowned self] filter in
            rootView.firstPeriod.setValue(phone: filter.firstData ?? "")
            rootView.secondPeriod.setValue(phone: filter.secondData ?? "")
            self.filter.onNext(filter)
            self.loadData.onNext(())
            self.kassSelected.onNext(true)
        }
        
        rootView.footerView.nextPageOpen = { [unowned self] page in
            self.skipValue.onNext((page-1)*stepsValue)
        }
        
        rootView.footerView.prevPageOpen = { [unowned self] page in
            self.skipValue.onNext((page-1)*stepsValue)
        }
        
        rootView.selectContainer.textField.rx.controlEvent(.editingDidBegin)
            .withLatestFrom(retailPoint)
            .subscribe(onNext: { [unowned self] point in
                if point == "" {
                    let pointId = self.points.first?.SellerID ?? 0
                    rootView.selectContainer.textField.text = self.points.first?.Name ?? ""
                    self.retailPoint.onNext(String(pointId))
                }
            })
            .disposed(by: disposeBag)
        
        let pdf = output.pdfUrl.publish()
        
        pdf.element.subscribe(onNext: { [unowned self] pdfResponse in
            if pdfResponse.Success == true {
                self.opendpdf(url: pdfResponse.Data)
            }
            print(pdfResponse)
            
        }).disposed(by: disposeBag)
        
        pdf.loading
            .bind(to: ProgressView.instance.rx.loading)
            .disposed(by: disposeBag)
        
        pdf.connect()
            .disposed(by: disposeBag)
        
        let successArray = [rootView.firstPeriod.isFilled, rootView.secondPeriod.isFilled, kassSelected]
        
        Observable.combineLatest(successArray).map { $0 }.map { $0.allSatisfy { $0 } }
            .distinctUntilChanged()
            .subscribe { [unowned self] success in
                if success.element ?? false {
                    self.loadData.onNext(())
                }
            }.disposed(by: disposeBag)
    }
    
    override func customBackButtonDidTap() {
        navigationController?.popViewController(animated: true)
    }
    
    private func opendpdf(url: String) {
        let remotePDFDocumentURL = URL(string: url)!
        let document = PDFDocument(url: remotePDFDocumentURL)!
        let readerController = PDFViewController.createNew(with: document)
        navigationController?.pushViewController(readerController, animated: true)
    }
}

extension KassOperationReportViewController: SpreadsheetViewDataSource {
    
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, widthForColumn column: Int) -> CGFloat {
        return ((rootView.frame.width - 50) / 4)
    }
    
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, heightForRow column: Int) -> CGFloat {
        return 45
    }
    
    func numberOfColumns(in spreadsheetView: SpreadsheetView) -> Int {
        return viewModel.arrayHeaders.count
    }
    
    func numberOfRows(in spreadsheetView: SpreadsheetView) -> Int {
        if let operations = operations?.data.sellerBalanceOperations {
            return operations.count + 1
        }
        return 0
    }
    
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, cellForItemAt indexPath: IndexPath) -> Cell? {
        let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: "cellid", for: indexPath) as! DataSheetTableViewCell
        if case (0...(viewModel.arrayHeaders.count), 0) = (indexPath.column, indexPath.row) {
            cell.titleLabel.text = viewModel.arrayHeaders[indexPath.column]
        } else if case (1...(operations?.data.sellerBalanceOperations.count ?? 0), 0...viewModel.arrayHeaders.count) = (indexPath.row, indexPath.column) {
            let items = operations?.data.sellerBalanceOperations[indexPath.row-1]

            if items?.operationType == "Оплата кредитной линии" {
                cell.titleLabel.textColor = .secondary
            } else {
                cell.titleLabel.textColor = .error
                
            }
            
            if indexPath.column == 0 {
                cell.titleLabel.text = "\(String(describing: items?.requestID ?? 0))"
            }
            if indexPath.column == 1 {
                cell.titleLabel.text = items?.date
            }
            if indexPath.column == 2 {
                cell.titleLabel.text = items?.sellerBalanceType.title
            }
            if indexPath.column == 3 {
                cell.titleLabel.text = items?.sellerName
            }
            
            if indexPath.column == 4 {
                switch viewModel.operationType {
                case .BonusHistory:
                    cell.titleLabel.text = "\(String(describing: items?.sum ?? 0)) тг"
                case .PaymentHistory:
                    cell.titleLabel.text = items?.counterParty
                }
            }
            if indexPath.column == 5 {
                switch viewModel.operationType {
                case .BonusHistory:
                    cell.titleLabel.text = items?.clientIIN
                case .PaymentHistory:
                    cell.titleLabel.text = "\(String(describing: items?.incomeSum ?? 0)) тг"
                }
            }
            
            if indexPath.column == 6 {
                switch viewModel.operationType {
                case .BonusHistory:
                    cell.titleLabel.text = "\(String(describing: items?.incomeSum ?? 0)) тг"
                case .PaymentHistory:
                    cell.titleLabel.text = "\(String(describing: items?.outgoingSum ?? 0)) тг"
                }
            }
        }
        return cell
    }
}

extension KassOperationReportViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return points.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let pointId = points[row].SellerID ?? 0
        rootView.selectContainer.textField.text = points[row].Name ?? ""
        kassSelected.onNext(true)
        retailPoint.onNext(String(pointId))
        loadData.onNext(())
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return points[row].Name
    }
}
