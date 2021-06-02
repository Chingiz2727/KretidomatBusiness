import UIKit

public struct CheapsSelectorItem {
    public enum FontSize {
        case body2
        case body1
    }
    public let title: String
    public let cornerRadius: CGFloat
    public let fontSize: FontSize
    
    public init(title: String, cornerRadius: CGFloat = 20.0, fontSize: FontSize = .body2) {
        self.title = title
        self.cornerRadius = cornerRadius
        self.fontSize = fontSize
    }
}

public class CheapsSelectorCollectionViewCell: UICollectionViewCell {
    var labelInsets: UIEdgeInsets = UIEdgeInsets(top: 8, left: 16.0, bottom: 8, right: 16.0) {
        didSet {
            setNeedsLayout()
        }
    }
    
    var centerLabelVertically: Bool = true {
        didSet {
            setNeedsLayout()
        }
    }
    
    let label: UILabel = {
        let label = UILabel()
        label.textColor = .primary
        label.font = .bold12
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        configureView()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        configureView()
    }
    
    private func setupView() {
        contentView.addSubview(label)
    }
    
    private func configureView() {
        backgroundColor = .background
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        label.sizeToFit()
        if centerLabelVertically {
            label.frame.origin.x = labelInsets.left
            label.center.y = contentView.bounds.midY
        } else {
            label.frame.origin = CGPoint(x: labelInsets.left, y: labelInsets.top)
        }
        let availableSpace: CGFloat = contentView.bounds.width - labelInsets.left - labelInsets.right
        label.frame.size.width = Swift.min(availableSpace, label.frame.width)
    }
    
    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        let height: CGFloat = size.height // Just set height of the cell as the height from the provided size
        let labelSize = label.sizeThatFits(CGSize(width: Swift.min(CGFloat.greatestFiniteMagnitude, size.width),
                                                  height: height))
        let width = labelSize.width + labelInsets.left + labelInsets.right
        return CGSize(width: width, height: height)
    }
    
    public func configure(with item: CheapsSelectorItem) {
        label.text = item.title
        self.layer.cornerRadius = item.cornerRadius
        setNeedsLayout()
        layoutIfNeeded()
    }
}
