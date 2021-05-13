import UIKit
import RxSwift

final class AboutKassaViewController: ViewController, ViewHolder, AboutKassaModule {
    
    typealias RootViewType = AboutKassaView
    
    private var pointPickerDelegate: PointPickerViewDelegate
    private var pointPickerDataSource: PointPickerViewDataSource
    private let pointPickerView = UIPickerView()
    private let disposeBag = DisposeBag()
    
    init() {
        self.pointPickerDataSource = PointPickerViewDataSource()
        self.pointPickerDelegate = PointPickerViewDelegate()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = AboutKassaView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setupPointPickerView()
    }
    
    private func bindViewModel() {
        rootView.tableView.registerClassForCell(PointCell.self)
    }
    
    private func setupPointPickerView() {
        pointPickerView.delegate = pointPickerDelegate
        pointPickerView.dataSource = pointPickerDataSource
        rootView.pointListTextField.textField.inputView = pointPickerView
    }
    
}
