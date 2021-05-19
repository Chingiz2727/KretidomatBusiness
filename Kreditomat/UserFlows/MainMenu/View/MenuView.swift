import Foundation
import UIKit

final class MenuView: UIView {
    let tableView = UITableView()
    let headerView = MenuHeaderView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInitialLayout()
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    private func setupInitialLayout() {
        addSubview(tableView)
        addSubview(headerView)
        headerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(140)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        tableView.registerClassForCell(UITableViewCell.self)
        tableView.tableFooterView = UIView()
//        tableView.tableHeaderView = MenuHeaderView(frame: CGRect(x: 0, y: 0, width: 0, height: 140))
    }
}
