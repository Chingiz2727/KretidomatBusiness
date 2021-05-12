import UIKit

public struct CheapsSelectorItem {
    public let title: String
    
    public init(title: String) {
        self.title = title
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
        label.textColor = .black
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 0
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
        backgroundColor = .white
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
        let labelSize = label.sizeThatFits(CGSize(width: Swift.min(CGFloat.greatestFiniteMagnitude, size.width),
                                                  height: Swift.min(CGFloat.greatestFiniteMagnitude, size.height)))
        let width = labelSize.width + labelInsets.left + labelInsets.right
        let height = labelSize.height + labelInsets.top + labelInsets.bottom
        return CGSize(width: width, height: 40)
    }
    
    func configure(with item: CheapsSelectorItem) {
        self.label.text = item.title
        setNeedsLayout()
        layoutIfNeeded()
    }
}
