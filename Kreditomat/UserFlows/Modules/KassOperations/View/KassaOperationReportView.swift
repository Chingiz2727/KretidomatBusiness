
import UIKit
import SpreadsheetView
import SnapKit
import Foundation

final class KassOperationReportView: UIView {
    
    let selectContainer = TextFieldContainer<RightButtonTextField>()
    private let sectionValue = SectionNameValueView()
    private var contentSizeObserver: NSKeyValueObservation?
    private var heightConstraint: Constraint?
    private let periodTitle = UILabel()
    let headerView = TableSheetHeaderDownload()
    let footerView = DataTableFooterView()
    let firstPeriod = DateTextField()
    let separotTitle = UILabel()
    let secondPeriod = DateTextField()
    let calendarButton = UIButton()
    var dataTable = SpreadsheetView()
    private let scrollView = UIScrollView()
    
    private lazy var calendarStack = UIStackView(views: [firstPeriod, separotTitle, secondPeriod], axis: .horizontal, distribution: .fill, alignment: .center, spacing: 7)
    
    private lazy var timeStack = UIStackView(views: [periodTitle, calendarStack, calendarButton], axis: .horizontal, distribution: .equalSpacing, alignment: .center, spacing: 10)
    
    private lazy var fullStack = UIStackView(views: [selectContainer, sectionValue, timeStack], axis: .vertical, distribution: .fill, spacing: 20)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInitialLayout()
        configureView()
//        contentSizeObserver = dataTable.observe(
//            \.contentSize,
//            options: [.initial, .new]
//        ) { [weak self] tableView, _ in
//            self?.heightConstraint?.update(offset: max(0, tableView.contentSize.height))
//        }
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    private func setupInitialLayout() {
        addSubview(scrollView)
        scrollView.snp.makeConstraints { $0.edges.width.height.equalTo(safeAreaLayoutGuide) }
        scrollView.addSubview(fullStack)
        fullStack.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(40)
            make.leading.width.trailing.equalToSuperview().inset(20)
        }
        
        firstPeriod.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
        
        secondPeriod.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
        footerView.isHidden = true
        selectContainer.snp.makeConstraints { $0.height.equalTo(40) }
        calendarButton.imageView?.contentMode = .scaleAspectFit
        calendarButton.snp.makeConstraints { $0.size.equalTo(30) }
        setupTable()
        heightConstraint?.activate()

    }
    
    func setView(data: PaymentOperations) {
        let operations: [NameValue] = [
            NameValue(name: "?????????????? ???? ????????????: ", value: "??????????"),
            NameValue(name: "?????????????? ??????????????", value: "\(data.data.totalSum) ??????????"),
            NameValue(name: "?????????? ???????????????? ??????????????", value: "\(data.data.totalPlus) ??????????")
        ]
        footerView.isHidden = false
        footerView.configureView(viewModel: data)
        sectionValue.setupValueView(value: operations)
        sectionValue.isHidden = false
        heightConstraint?.update(offset: max(dataTable.contentSize.height, dataTable.contentSize.height))
        
    }
    
    func setupTable() {
        scrollView.addSubview(dataTable)
        scrollView.addSubview(headerView)
        scrollView.addSubview(footerView)
        headerView.snp.makeConstraints { make in
            make.top.equalTo(fullStack.snp.bottom).offset(10)
            make.height.equalTo(40)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        dataTable.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            heightConstraint = make.height.equalTo(0).constraint
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        footerView.snp.makeConstraints { make in
            make.top.equalTo(dataTable.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(40)
            make.bottom.equalToSuperview().inset(100)
        }
    }

    private func configureView() {
        dataTable.register(DataSheetTableViewCell.self, forCellWithReuseIdentifier: "cellid")
//        dataTable.layer.borderWidth = 2
//        dataTable.layer.borderColor = UIColor.primary.cgColor
        selectContainer.textField.placeholder = "??????..."
        separotTitle.text = "-"
        periodTitle.text = "????????????: "
        periodTitle.font = .systemFont(ofSize: 12)
        periodTitle.textColor = .black
        separotTitle.font = .systemFont(ofSize: 12)
        calendarButton.backgroundColor = .primary
        calendarButton.setImage(#imageLiteral(resourceName: "schedule"), for: .normal)
        calendarButton.layer.cornerRadius = 4
        selectContainer.title = "???????????????? ??????????"
        selectContainer.textField.setButtonImage(image: #imageLiteral(resourceName: "arrowbottom"))
        sectionValue.layer.cornerRadius = 3
        sectionValue.layer.borderWidth = 1
        sectionValue.layer.borderColor = UIColor.secondary.cgColor
        calendarButton.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        firstPeriod.layer.cornerRadius = 5
        secondPeriod.layer.cornerRadius = 5
        dataTable.layer.cornerRadius = 8
        sectionValue.isHidden = true
        headerView.layer.cornerRadius = 8
        backgroundColor = .background
    }
}
