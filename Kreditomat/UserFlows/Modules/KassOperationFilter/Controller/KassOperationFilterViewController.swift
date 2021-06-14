import RxSwift
import UIKit

class KassOperationFilterViewController: UIViewController, KassOperationFilterModule, ViewHolder {
    var onFilterSended: OnFilterSended?
    private let diposeBag = DisposeBag()
    typealias RootViewType = KassOperationFilterView
    
    override func loadView() {
        view = KassOperationFilterView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rootView.acceptButton.rx.tap
            .subscribe(onNext: { [unowned self] in
                let filter = KassFilter(firsDate: rootView.firstPeriod.selectedDate, secondDate: rootView.secondPeriod.selectedDate, period: 1)
                self.onFilterSended?(filter)
            })
            .disposed(by: diposeBag)
        
    }
    
}
