
import UIKit
import SpreadsheetView
import Foundation

final class KassOperationReportView: UIView {
    
    private let selectContainer = TextFieldContainer<RightButtonTextField>()
    private let sectionValue = SectionNameValueView()
    
    private let periodTitle = UILabel()
    private let headerView = TableSheetHeaderDownload()
    let firstPeriod = RegularTextField()
    let separotTitle = UILabel()
    let secondPeriod = RegularTextField()
    let calendarButton = UIButton()
    var dataTable = SpreadsheetView()
    
    private lazy var calendarStack = UIStackView(views: [firstPeriod, separotTitle, secondPeriod], axis: .horizontal, distribution: .fill, alignment: .center, spacing: 7)
    
    private lazy var timeStack = UIStackView(views: [periodTitle, calendarStack, calendarButton], axis: .horizontal, distribution: .equalSpacing, alignment: .center, spacing: 10)
    
    private lazy var fullStack = UIStackView(views: [selectContainer, sectionValue, timeStack], axis: .vertical, distribution: .fill, spacing: 20)
    
    private let operations: [NameValue] = [
        NameValue(name: "Обороты по точкам: ", value: "Общие"),
        NameValue(name: "ИП/ТОО", value: "Наименование отчета"),
        NameValue(name: "Текущий остаток", value: "1 000 000 тенге"),
        NameValue(name: "Общий входящий остаток", value: "1 000 000 тенге")
    ]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInitialLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    private func setupInitialLayout() {
        addSubview(fullStack)
        fullStack.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).inset(20)
            make.leading.width.trailing.equalToSuperview().inset(20)
        }
        
        firstPeriod.snp.makeConstraints { make in
            make.width.equalTo(75)
            make.height.equalTo(30)
        }
        
        secondPeriod.snp.makeConstraints { make in
            make.width.equalTo(75)
            make.height.equalTo(30)
        }
        
        selectContainer.snp.makeConstraints { $0.height.equalTo(60) }
        calendarButton.imageView?.contentMode = .scaleAspectFit
        calendarButton.snp.makeConstraints { $0.size.equalTo(30) }
        setupTable()
    }
    
    func setupTable() {
        addSubview(dataTable)
        addSubview(headerView)
        
        headerView.snp.makeConstraints { make in
            make.top.equalTo(fullStack.snp.bottom).offset(10)
            make.height.equalTo(40)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        dataTable.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.height.equalTo(400)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }

    private func configureView() {
        dataTable.register(DataSheetTableViewCell.self, forCellWithReuseIdentifier: "cellid")
//        dataTable.layer.borderWidth = 2
//        dataTable.layer.borderColor = UIColor.primary.cgColor
        separotTitle.text = "-"
        periodTitle.text = "Период: "
        periodTitle.font = .systemFont(ofSize: 12)
        periodTitle.textColor = .black
        separotTitle.font = .systemFont(ofSize: 12)
        calendarButton.backgroundColor = .primary
        calendarButton.setImage(#imageLiteral(resourceName: "schedule"), for: .normal)
        calendarButton.layer.cornerRadius = 4
        selectContainer.title = "Выберите точку"
        selectContainer.textField.setButtonImage(image: #imageLiteral(resourceName: "arrowbottom"))
        sectionValue.setupValueView(value: operations)
        sectionValue.layer.cornerRadius = 3
        sectionValue.layer.borderWidth = 2
        sectionValue.layer.borderColor = UIColor.secondary.cgColor
        calendarButton.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        firstPeriod.layer.cornerRadius = 5
        secondPeriod.layer.cornerRadius = 5
        dataTable.layer.cornerRadius = 8
        backgroundColor = .white
    }
}
