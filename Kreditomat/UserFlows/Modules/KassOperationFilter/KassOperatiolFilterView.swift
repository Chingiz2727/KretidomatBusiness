import Koyomi
import UIKit

final class KassOperationFilterView: UIView {
    private let titleLabel = UILabel()
    let timesView = CheapsSelectorView()
    private let timesLabel = UILabel()
    private let firstPeriod = CalendarView()
    private let secondPeriod = Koyomi(frame: .zero, sectionSpace: 0, cellSpace: 0, inset: UIEdgeInsets.init(top: 3, left: 3, bottom: 3, right: 3), weekCellHeight: 30)
    let cancelButton = PrimaryButton()
    let acceptButton = PrimaryButton()
    
    private lazy var buttonStackView = UIStackView(
        views: [cancelButton, acceptButton],
        axis: .horizontal,
        distribution: .fillEqually,
        spacing: 10)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInitialLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupInitialLayout()
        configureView()
    }
    
    private func setupInitialLayout() {
        addSubview(titleLabel)
        addSubview(timesView)
        addSubview(timesLabel)
        addSubview(firstPeriod)
        addSubview(secondPeriod)
        addSubview(buttonStackView)

        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(safeAreaLayoutGuide).inset(10)
        }
        
        timesView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(10)
            make.height.equalTo(44)
        }
    
        timesLabel.snp.makeConstraints { make in
            make.top.equalTo(timesView.snp.bottom).offset(10)
            make.leading.equalToSuperview().inset(10)
        }
        
        firstPeriod.snp.makeConstraints { make in
            make.top.equalTo(timesLabel.snp.bottom).offset(10)
            make.height.equalTo(200)
            make.leading.trailing.equalToSuperview().inset(50)
            make.centerX.equalToSuperview()
        }
        
        secondPeriod.snp.makeConstraints { make in
            make.top.equalTo(firstPeriod.snp.bottom).offset(10)
            make.height.equalTo(200)
            make.leading.trailing.equalToSuperview().inset(50)
            make.centerX.equalToSuperview()
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview().inset(10)
            make.height.equalTo(44)
        }
    }
    
    private func configureView() {
        titleLabel.font = .bold12
        titleLabel.font = .bold12

        secondPeriod.weeks = ("вс","пн","вт","ср","чт","пт","сб")


        secondPeriod.holidayColor.saturday = .red
        secondPeriod.holidayColor.sunday = .red
        secondPeriod.isHiddenOtherMonth = true
        secondPeriod.separatorColor = .clear
        secondPeriod.sectionSeparatorColor = .clear

        secondPeriod.circularViewDiameter = 0.5
        secondPeriod.selectionMode = .single(style: .circle)
        secondPeriod.selectedStyleColor = .primary
        cancelButton.setTitle("Отмена", for: .normal)
        acceptButton.setTitle("Применить", for: .normal)
        acceptButton.layer.cornerRadius = 12
        cancelButton.layer.cornerRadius = 12

        secondPeriod.setDayFont(size: 11)
        secondPeriod.setWeekFont(size: 12)
        timesView.setupCollectionItems(collectionItems: [.init(title: "За неделю"), .init(title: "За месяц"), .init(title: "За полгода"), .init(title: "За год")])
        backgroundColor = .white
        
    }
}
