import SpreadsheetView
import UIKit

class KassOperationReportViewController: UIViewController, KassOperationReportModule, ViewHolder {
    typealias RootViewType = KassOperationReportView
    
    private let operationTitle: [String] = ["ID операции", "Дата и время", "Тип операции", "ФИО Кассира", "Текущий остаток"]
    override func loadView() {
        view = KassOperationReportView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        rootView.dataTable.dataSource = self
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
        return 9
    }
    
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, cellForItemAt indexPath: IndexPath) -> Cell? {
        let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: "cellid", for: indexPath) as! DataSheetTableViewCell
        print(indexPath.column)
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
            cell.titleLabel.text = "\(indexPath.row)"
        }
        
        return cell
    }
}
