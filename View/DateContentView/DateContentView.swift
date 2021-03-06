import UIKit

final class DateContentView: UIView {
    
    var selectedDate: String?
    let textField = RegularTextField()
    private let datePicker = UIDatePicker()
    let titleLabel = UILabel()
    
    private lazy var stackView = UIStackView(arrangedSubviews: [titleLabel, textField])
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        addSubview(stackView)
        titleLabel.text = "Время до"
        stackView.snp.makeConstraints { $0.edges.equalToSuperview() }
        textField.snp.makeConstraints { $0.height.equalTo(44) }
        datePicker.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)

        textField.inputView = datePicker
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        datePicker.locale = Locale(identifier: "ru_RU")
        datePicker.datePickerMode = .date
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        stackView.spacing = 5
    }
    
    @objc func handleDatePicker(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-dd-MM"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        selectedDate = dateFormatter.string(from: sender.date)
        textField.text = dateFormatter.string(from: sender.date)
    }
    
    func selectDate(item: SelectedDateItem) {
        print(item.rawValue)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-dd-MM"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        let today = Date()
        var components = DateComponents()
        components.day = -item.rawValue
        let laterDay = Calendar.current.date(byAdding: components, to: today)
        selectedDate = dateFormatter.string(from: laterDay!)
        textField.text = dateFormatter.string(from: laterDay!)
    }
    
    func selectCurrentDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-dd-MM"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        
        let today = Date()
        selectedDate = dateFormatter.string(from: today)
        textField.text = dateFormatter.string(from: today)
    }
    
    func currentDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        let today = Date()
        selectedDate = dateFormatter.string(from: today)
        textField.text = dateFormatter.string(from: today)
    }
}

extension DateFormatter {
    
    class func formattedDottedFullDate(_ dateStr: String?) -> String? {
        let formatter = fullDateFormatter()
        if let dateStr = dateStr, let date = formatter.date(from: dateStr) {
            formatter.dateFormat = "yyyy-MM-dd"
            return formatter.string(from: date)
        }
        return nil
    }
    
    class func formatterDottedWithoutT(_ dateStr: String?) -> String? {
        let formatter = fullDateWithoutT()
        if let dateStr = dateStr, let date = formatter.date(from: dateStr) {
            formatter.dateFormat = "yyyy-MM-dd"
            return formatter.string(from: date)
        }
        return nil
    }
    
    private class func fullDateFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-dd-MM"
        return formatter
    }
    
    private class func fullDateWithoutT() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return formatter
    }
}

