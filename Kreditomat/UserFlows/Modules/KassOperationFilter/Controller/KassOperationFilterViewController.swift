import RxSwift
import UIKit

class KassOperationFilterViewController: ViewController, KassOperationFilterModule, ViewHolder {
    var onFilterSended: OnFilterSended?
    private let disposeBag = DisposeBag()
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
                let filter = KassFilter(firsDate: rootView.firstPeriod.startDate ?? Date(), secondDate: rootView.firstPeriod.endDate ?? Date(), period: rootView.timesView.selectedIndex)
                self.onFilterSended?(filter)
            })
            .disposed(by: disposeBag)
        rootView.cancelButton.rx.tap
            .subscribe(onNext: { [unowned self] in
                navigationController?.popViewController(animated: true)
            }).disposed(by: disposeBag)
    }
    
    override func customBackButtonDidTap() {
        navigationController?.popViewController(animated: true)
    }
}
