import RxSwift
import UIKit

class KassOperationFilterViewController: ViewController, KassOperationFilterModule, ViewHolder {
    var onFilterSended: OnFilterSended?
    private let diposeBag = DisposeBag()
    typealias RootViewType = KassOperationFilterView
    
    override func loadView() {
        view = KassOperationFilterView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Фильтр"
        navigationController?.navigationBar.layer.addShadow()

        rootView.acceptButton.rx.tap
            .subscribe(onNext: { [unowned self] in
                let filter = KassFilter(firsDate: rootView.firstPeriod.selectedDate, secondDate: rootView.secondPeriod.selectedDate, period: rootView.timesView.selectedIndex)
                self.onFilterSended?(filter)
            })
            .disposed(by: diposeBag)
    }
    
    override func customBackButtonDidTap() {
        navigationController?.popViewController(animated: true)
    }
}
