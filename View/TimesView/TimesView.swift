import UIKit

final class TimesView: UIView {
    private lazy var stackView = UIStackView(arrangedSubviews: [])
    var selectedIndex = 0
    var buttons: [UIButton: ((Int)->Void)] = [:]
    var atItemSelect: ((Int)->Void)?
    private var buttonsArray: [UIButton] = []
    private var titles: [String] = []

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(stackView)
        stackView.snp.makeConstraints { $0.edges.equalToSuperview() }
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setTitles(titles: [String]) {
        self.titles = titles
        titles.forEach { title in
            setButton(title: title)
        }
    }
    
    func setButton(title: String) {
        let button = UIButton()
        button.tag = titles.lastIndexOf(title)! + 1
        button.setTitle(title, for: .normal)
        button.configureDeselected()
        button.addTarget(self, action: #selector(selectButton(_:)), for: .touchUpInside)
        button.titleLabel?.font = .bold10
        buttonsArray.append(button)
        stackView.addArrangedSubview(button)
        button.snp.makeConstraints { $0.height.equalTo(30) }
    }
    
    @objc func selectButton(_ sender: UIButton) {
        buttonsArray.forEach { $0.configureDeselected() }
        sender.configureSelected()
        selectedIndex = sender.tag
        atItemSelect?(sender.tag)
        sender.configureSelected()
    }
}

extension UIButton {
    func configureSelected() {
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.cornerRadius = 8
        self.backgroundColor = .primary
        self.setTitleColor(.white, for: .normal)
    }
    
    func configureDeselected() {
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.primary.cgColor
        self.layer.cornerRadius = 8
        self.backgroundColor = .white
        self.setTitleColor(.black, for: .normal)
    }
}

extension Array where Element: Equatable {
    
    func indexes(of element: Element) -> [Int] {
        return enumerated().compactMap { ($0.element == element) ? $0.offset : nil }
    }
    
    func lastIndex(of element: Element) -> Int? {
        return indexes(of: element).last
    }
    
    mutating func removeFirst(_ element: Element) {
        guard let index = index(of: element) else { return }
        remove(at: index)
    }
    
    public mutating func removeAll(_ elements: [Element]) {
        self = filter { !elements.contains($0) }
    }
    
    public func unique() -> Array {
        return reduce([]) { $0.contains($1) ? $0 : $0 + [$1] }
    }
    
    mutating func removeFirstObject(_ object: Element) {
        removeFirst(object)
    }
    
    public func indexesOf(_ object: Element) -> [Int] {
        return indexes(of: object)
    }
    
    public func lastIndexOf(_ object: Element) -> Int? {
        return lastIndex(of: object)
    }
    
    public mutating func removeObject(_ object: Element) {
        removeFirstObject(object)
    }
}
