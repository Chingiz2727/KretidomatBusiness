import Koyomi
import UIKit

final class KassOperationFilterView: UIView {
    private let scrollView = UIScrollView()
    private let titleLabel = UILabel()
    let timesView = TimesView()
    private let timesLabel = UILabel()
    let firstPeriod = CalendarView()
    
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
        addSubview(scrollView)
        scrollView.snp.makeConstraints { $0.edges.width.height.equalToSuperview() }
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(timesView)
        scrollView.addSubview(timesLabel)
        scrollView.addSubview(firstPeriod)
//        scrollView.addSubview(secondPeriod)
        scrollView.addSubview(buttonStackView)

        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(10)
        }
        
        timesView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(10)
            make.height.equalTo(33)
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
        
//        secondPeriod.snp.makeConstraints { make in
//            make.top.equalTo(firstPeriod.snp.bottom).offset(10)
//            make.height.equalTo(200)
//            make.leading.trailing.equalToSuperview().inset(50)
//            make.centerX.equalToSuperview()
//        }
        
        buttonStackView.snp.makeConstraints { make in
            make.top.equalTo(firstPeriod.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(100)
            make.height.equalTo(40)
        }
        timesView.atItemSelect = { [weak self] index in
            switch index {
            case 1:
                self?.firstPeriod.selectDate(item: .week)
            case 2:
                self?.firstPeriod.selectDate(item: .month)
            case 3:
                self?.firstPeriod.selectDate(item: .halfYear)
            case 4:
                self?.firstPeriod.selectDate(item: .year)
            default:
                break
            }
        }
        
    }
    
    private func configureView() {
        titleLabel.font = .bold12
        titleLabel.font = .bold12
//        secondPeriod.nextMonth()
        timesView.setTitles(titles: ["За неделю","За месяц","За полгода","За год"])
        backgroundColor = .white
        cancelButton.setTitle("Отмена", for: .normal)
        acceptButton.setTitle("Применить", for: .normal)
        acceptButton.layer.cornerRadius = 12
        cancelButton.layer.cornerRadius = 12
        titleLabel.text = "Выберите период"
        titleLabel.font = .regular12
        timesLabel.font = .regular12
        timesLabel.text = "Укажите определенный период вручную"
        backgroundColor = .background
    }
}
