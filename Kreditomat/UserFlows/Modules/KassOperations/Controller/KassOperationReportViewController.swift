import RxSwift
import SpreadsheetView
import UIKit

class KassOperationReportViewController: ViewController, KassOperationReportModule, ViewHolder {
    var onfilterSelect: OnFilterSelect?
    
    typealias RootViewType = KassOperationReportView
    var filterTapped: FilterTapped?
    private let disposeBag = DisposeBag()
    private let viewModel = KassOperationsViewModel()
    private let filter = PublishSubject<KassFilter>()
    private let retailPoint = PublishSubject<String>()
    private let pickerView = UIPickerView()
    private let operationTitle: [String] = ["ID операции", "Дата и время", "Тип операции", "ФИО Кассира", "Текущий остаток"]
    private var points: [Point] = []
    private var operations: PaymentOperations?
    
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
        bindViewModel()
    }

    private func bindViewModel() {
        let output = viewModel.transform(input: .init(filter: filter, retailPoint: retailPoint, loadPoint: .just(())))
        
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
                self.operations = data
                DispatchQueue.main.async {
                    self.rootView.dataTable.reloadData()
                    self.rootView.dataTable.reloadInputViews()
                    self.rootView.setView(data: data)
                }
            })
            .disposed(by: disposeBag)
        history.connect()
            .disposed(by: disposeBag)
        
        pickerView.dataSource = self
        pickerView.delegate = self
        rootView.selectContainer.textField.inputView = pickerView
        
        onfilterSelect = { [unowned self] filter in
            rootView.firstPeriod.text = filter.firstData
            rootView.secondPeriod.text = filter.secondData
            self.filter.onNext(filter)
        }
    }
}

extension KassOperationReportViewController: SpreadsheetViewDataSource {
    
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, widthForColumn column: Int) -> CGFloat {
        return ((rootView.frame.width - 50) / 5)
    }
    
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, heightForRow column: Int) -> CGFloat {
        return 35
    }
    
    func numberOfColumns(in spreadsheetView: SpreadsheetView) -> Int {
        return 5
    }
    
    func numberOfRows(in spreadsheetView: SpreadsheetView) -> Int {
        return operations?.data.sellerBalanceOperations.count ?? 0
    }
    
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, cellForItemAt indexPath: IndexPath) -> Cell? {
        let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: "cellid", for: indexPath) as! DataSheetTableViewCell
        print(indexPath.column)
        let items = operations?.data.sellerBalanceOperations[indexPath.row]
        if case (0...(5), 0) = (indexPath.column, indexPath.row) {
            cell.titleLabel.text = operationTitle[indexPath.column]
            cell.backgroundColor = .primary.withAlphaComponent(0.1)

        } else if case (0...(9), 0...5) = (indexPath.row, indexPath.column) {
            if indexPath.row % 2 != 0 {
                cell.titleLabel.textColor = .secondary
            } else {
                cell.titleLabel.textColor = .error
            }
            if indexPath.column == 0 {
                cell.backgroundColor = .primary.withAlphaComponent(0.1)
            }
            if indexPath.column == 0 {
                cell.titleLabel.text = "\(items?.requestID)"
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
                cell.titleLabel.text = "\(items?.sum) тг"
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
        retailPoint.onNext(String(pointId))
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return points[row].Name
    }
}
