import Koyomi
import UIKit

final class CalendarView: UIView {
    private let backView = UIView()
    let calendarView = Koyomi(frame: .zero, sectionSpace: 0, cellSpace: 0, inset: UIEdgeInsets.init(top: 3, left: 3, bottom: 3, right: 3), weekCellHeight: 30)
    private let nextButton = UIButton()
    private let previousButton = UIButton()
    private let titleLabel =  UILabel()
    private lazy var stackView = UIStackView(arrangedSubviews: [nextButton, titleLabel, previousButton])
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInitialLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    private func setupInitialLayout() {
        addSubview(backView)
        backView.snp.makeConstraints { $0.edges.equalToSuperview() }
        backView.addSubview(stackView)
        backView.addSubview(calendarView)
        
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(5)
            make.height.equalTo(20)
            make.centerX.equalToSuperview()
        }
        
        calendarView.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(5)
            make.bottom.leading.trailing.equalToSuperview().inset(2)
        }
    }
    
    private func configureView() {
        calendarView.separatorColor = .clear
        calendarView.dayBackgrondColor = .white
        calendarView.weeks = ("вс","пн","вт","ср","чт","пт","сб")
        calendarView.holidayColor.saturday = .red
        calendarView.holidayColor.sunday = .red
        calendarView.isHiddenOtherMonth = true
        calendarView.sectionSeparatorColor = .clear
        calendarView.selectionMode = .single(style: .circle)
        calendarView.weekBackgrondColor = .white
        calendarView.circularViewDiameter = 0.5
        calendarView.selectedStyleColor = .primary
        calendarView.setDayFont(size: 11)
        calendarView.setWeekFont(size: 12)
        backView.backgroundColor = .secondary
        backView.layer.cornerRadius = 6
        titleLabel.text = calendarView.currentDateString()
    }
}


