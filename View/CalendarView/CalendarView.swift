import FSCalendar
import Koyomi
import UIKit

final class CalendarView: UIView {
    private let backView = UIView()
    let calendarView = Koyomi(frame: .zero, sectionSpace: 0, cellSpace: 0, inset: UIEdgeInsets.init(top: 3, left: 3, bottom: 3, right: 3), weekCellHeight: 30)
    
    private let nextButton = UIButton()
    private let previousButton = UIButton()
    private let titleLabel =  UILabel()
    var startDate : Date?
    private var datesRange: [Date]?
    
    var endDate: Date?
    private lazy var stackView = UIStackView(arrangedSubviews: [previousButton, titleLabel, nextButton])
    
    var selectedDate = Date()
    private let propertyFormattter = assembler.resolver.resolve(PropertyFormatter.self)!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInitialLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    func selectDate(item: SelectedDateItem) {
        print(item.rawValue)
        let today = Date()
        var components = DateComponents()
        components.day = item.rawValue
        let laterDay = Calendar.current.date(byAdding: components, to: today)
        let datesList = Date.dates(from: today, to: laterDay!)
//        calendarView.select(date: today)
        print(datesList.count)
        calendarView.select(dates: datesList)
        calendarView.select(date: today)
//        selectByRange(date: datesList)
        //        calendarView.select(dates: datesList)
        //        calendarView.select(date: today, to: weekLaterDay)
    }
    
    private func setupInitialLayout() {
        addSubview(backView)
        backView.snp.makeConstraints { $0.edges.equalToSuperview() }
        backView.addSubview(stackView)
        backView.addSubview(calendarView)
        
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(5)
            make.height.equalTo(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
        }
        
        calendarView.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(5)
            
            make.bottom.leading.trailing.equalToSuperview().inset(0.3)
        }
    }
    
    private func configureView() {
        calendarView.separatorColor = .clear
        calendarView.dayBackgrondColor = .white
        calendarView.weeks = ("вс","пн","вт","ср","чт","пт","сб")
        calendarView.holidayColor.saturday = .red
        calendarView.holidayColor.sunday = .red
        calendarView.isHiddenOtherMonth = false
        calendarView.sectionSeparatorColor = .clear
        calendarView.selectionMode = .single(style: .circle)
        calendarView.weekBackgrondColor = .white
        calendarView.circularViewDiameter = 0.5
        calendarView.selectedStyleColor = .primary
        calendarView.setDayFont(size: 11)
        calendarView.setWeekFont(size: 12)
        calendarView.isHiddenOtherMonth = true
        backView.backgroundColor = .secondary
        titleLabel.font = .regular14
        backView.layer.cornerRadius = 6
        calendarView.calendarDelegate = self
        calendarView.selectionMode = .sequence(style: .circle)
        calendarView.isMultipleTouchEnabled = true
        let date = propertyFormattter.string(from: Date(), type: .fullMonthWithYear)

        let backimage = UIImage(named: "back_black")?.withRenderingMode(.alwaysTemplate)
        previousButton.setImage(backimage, for: .normal)
        previousButton.imageView?.tintColor = .white
        let nextImage = UIImage(cgImage: backimage!.cgImage!, scale: 0, orientation: .down).withRenderingMode(.alwaysTemplate)
        nextButton.imageView?.tintColor = .white
        nextButton.imageView?.contentMode = .scaleAspectFit
        previousButton.imageView?.contentMode = .scaleAspectFit
        nextButton.setImage(nextImage, for: .normal)
        nextButton.snp.makeConstraints { $0.size.equalTo(13) }
        previousButton.snp.makeConstraints { $0.size.equalTo(13) }
        titleLabel.text = date?.capitalized
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        stackView.spacing = 20
        previousButton.addTarget(self, action: #selector(prevMonth), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextMonth), for: .touchUpInside)
    }
    
    
    @objc func nextMonth() {
        let nextMonth = Calendar.current.date(byAdding: .month, value: 1, to: selectedDate)
        selectedDate = nextMonth!
        let date = propertyFormattter.string(from: nextMonth!, type: .fullMonthWithYear)
        titleLabel.text = date?.capitalized
        calendarView.display(in: .next)
    }
    
    @objc func prevMonth() {
        let prevMonth = Calendar.current.date(byAdding: .month, value: -1, to: selectedDate)
        selectedDate = prevMonth!
        let date = propertyFormattter.string(from: prevMonth!, type: .fullMonthWithYear)
        titleLabel.text = date?.capitalized
    }
}

extension CalendarView: KoyomiDelegate {
    func koyomi(_ koyomi: Koyomi, didSelect date: Date?, forItemAt indexPath: IndexPath) {
        
    }
    
    func koyomi(_ koyomi: Koyomi, shouldSelectDates date: Date?, to toDate: Date?, withPeriodLength length: Int) -> Bool {
        startDate = date
        endDate = toDate
        return true
    }
}

enum SelectedDateItem: Int {
    case week = 7
    case month = 31
    case halfYear = 182
    case year = 365
}

extension Date {
    static func dates(from fromDate: Date, to toDate: Date) -> [Date] {
        var dates: [Date] = []
        var date = fromDate
        
        while date <= toDate {
            dates.append(date)
            guard let newDate = Calendar.current.date(byAdding: .day, value: 1, to: date) else { break }
            date = newDate
        }
        return dates
    }
}
