import UIKit

 struct NameValue {
     let name: String
     let value: String
 }

 final class SectionNameValueView: UIView {
     private lazy var verticalStack = UIStackView(views: [], axis: .vertical, distribution: .fill, spacing: 2)

     override init(frame: CGRect) {
         super.init(frame: frame)

     }

     required init?(coder: NSCoder) {
         nil
     }

     func setupValueView(value: [NameValue]) {
        verticalStack.removeFullyAllArrangedSubviews()
        addSubview(verticalStack)
        verticalStack.snp.makeConstraints { $0.edges.width.height.equalToSuperview().inset(10) }
         value.forEach { item in
             let valueView = NameValueView()
             valueView.setup(title: item.name)
             valueView.setup(detail: item.value)
             verticalStack.addArrangedSubview(valueView)
         }
     }
 }
extension UIStackView {
    
    func removeFully(view: UIView) {
        removeArrangedSubview(view)
        view.removeFromSuperview()
    }
    
    func removeFullyAllArrangedSubviews() {
        arrangedSubviews.forEach { (view) in
            removeFully(view: view)
        }
    }
    
}
