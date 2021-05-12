import UIKit

public protocol CheapsSelectorViewDelegate: class {
    func cheapsSelectorView(_ view: CheapsSelectorView, didSelectCategory category: CheapsSelectorItem)
}

public class CheapsSelectorView: UIView {

    public static let prefferedHeight: CGFloat = 40.0
    private let reuseIdentifier = "reuseIdentifier"
    weak var delegate: CheapsSelectorViewDelegate?
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    private lazy var layout: CheapsSelectorLayoutSource = { [unowned self] in
        let layout = CheapsSelectorLayoutSource()
        layout.itemAt = {
            return self.collectionItems[$0.item]
        }
        layout.container = self.collectionView
        return layout
    }()
    
    private var collectionItems: [CheapsSelectorItem] = []
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        configureView()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        layout.inset.top = 5
        layout.inset.bottom = 5
        collectionView.backgroundColor = backgroundColor
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    public func setupCollectionItems(collectionItems: [CheapsSelectorItem]) {
        self.collectionItems = collectionItems
        collectionView.reloadData()
    }
    
    private func setupView() {
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    private func configureView() {
        collectionView.register(CheapsSelectorCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension CheapsSelectorView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    /// Data source
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionItems.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CheapsSelectorCollectionViewCell
        cell.configure(with: collectionItems[indexPath.item])
        return cell
    }
    
    /// Delegate
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return layout.inset
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return layout.minimumLineSpacing
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return layout.minimumInteritemSpacing
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = layout.itemSize(at: indexPath)
        return size
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = self.collectionItems[indexPath.item]
        delegate?.cheapsSelectorView(self, didSelectCategory: category)
    }
}

class CheapsSelectorLayoutSource {
    private static let helperView = CheapsSelectorCollectionViewCell()
    static let expectedCellHeight: CGFloat = 40.0
    var container = UIView()
    var itemAt: ((IndexPath) -> CheapsSelectorItem)?
    var inset: UIEdgeInsets = .zero
    var minimumLineSpacing: CGFloat = 0
    var minimumInteritemSpacing: CGFloat = 0
    
    init() {
        inset.left = 5
        inset.right = 5
        inset.top = 4.0
        inset.bottom = 4.0
        minimumInteritemSpacing = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func itemSize(at indexPath: IndexPath) -> CGSize {
        guard let itemAt = itemAt, container.frame.height > 0 else { return .zero }

        let item = itemAt(indexPath)
        CheapsSelectorLayoutSource.helperView.configure(with: item)
        let cellSize = CheapsSelectorLayoutSource.helperView.sizeThatFits(
            CGSize(width: CGFloat.greatestFiniteMagnitude, height: CheapsSelectorLayoutSource.expectedCellHeight))
        return cellSize
    }
}
