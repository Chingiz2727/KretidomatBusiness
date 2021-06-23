import UIKit

final class DataTableFooterView: UIView {
    
    var prevPageOpen: ((Int) -> Void)?
    var nextPageOpen: ((Int) -> Void)?
    
    private let downloadButton = UIButton()
    private let nextButton = UIButton()
    private let previousButton = UIButton()
    private lazy var titlesStack = UIStackView(arrangedSubviews: [])
    private lazy var stackView = UIStackView(arrangedSubviews: [UIView(),previousButton, titlesStack, nextButton,UIView()])
    private lazy var titleLabels: [UILabel] = []
    private lazy var currentPage: Int = 1 {
        didSet {
            if currentPage == 1 {
                previousButton.isHidden = true
            } else {
                previousButton.isHidden = false
            }
            
            if currentPage == titleLabels.count {
                nextButton.isHidden = true
            } else {
                nextButton.isHidden = false
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInitialLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    func configureView(viewModel: PaymentOperations) {
        if titleLabels.count != viewModel.data.pagesCount {
            titlesStack.removeFullyAllArrangedSubviews()
            titleLabels.removeAll()
            for i in 1...viewModel.data.pagesCount {
                let titleLabel =  UILabel()
                titleLabel.textAlignment = .center
                titleLabel.text = "\(i)"
                titleLabel.font = .boldSystemFont(ofSize: 13)
                titleLabel.textColor = .gray
                titleLabel.textAlignment = .center
                if i == 1 {
                    titleLabel.textColor = .white
                }
                titleLabel.tag = i
                titleLabels.append(titleLabel)
                titlesStack.addArrangedSubview(titleLabel)
            }
        }
        if currentPage == 1 {
            previousButton.isHidden = true
        } else {
            previousButton.isHidden = false
        }
        
        if currentPage == titleLabels.count {
            nextButton.isHidden = true
        } else {
            nextButton.isHidden = false
        }
    }
    
    private func setupInitialLayout() {
        addSubview(stackView)
        stackView.snp.makeConstraints { $0.center.equalToSuperview() }
        backgroundColor = .primary
        layer.cornerRadius = 8
    }
    
    private func configureView() {
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
//        titleLabel.text = date?.capitalized
        stackView.spacing = 20
        previousButton.addTarget(self, action: #selector(prevPage), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextPage), for: .touchUpInside)
        titlesStack.distribution = .fillEqually
        titlesStack.spacing = 5
        titlesStack.axis = .horizontal
    }
    
    @objc private func nextPage() {
        if currentPage < titleLabels.count {
            currentPage += 1
            titleLabels.forEach { $0.textColor = .gray }
            titleLabels[currentPage-1].textColor = .white
            nextPageOpen?(currentPage)
        }
    }
    
    @objc private func prevPage() {
        if currentPage >= 1 {
            currentPage -= 1
            titleLabels.forEach { $0.textColor = .gray }
            if currentPage == 0 {
                titleLabels[0].textColor = .white
            } else {
                titleLabels[currentPage-1].textColor = .white
            }
            prevPageOpen?(currentPage)
        }
    }
}
