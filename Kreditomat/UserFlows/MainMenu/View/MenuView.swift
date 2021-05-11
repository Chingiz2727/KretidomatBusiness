import Foundation
import UIKit

final class MenuView: UIView {
    let tableView = UITableView()
    private let headerView = MenuHeaderView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInitialLayout()
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    private func setupInitialLayout() {
        addSubview(tableView)
        tableView.snp.makeConstraints { $0.edges.equalToSuperview() }
        tableView.registerClassForCell(UITableViewCell.self)
        tableView.tableFooterView = UIView()
        tableView.tableHeaderView = MenuHeaderView(frame: CGRect(x: 0, y: 0, width: 0, height: 140))
    }
}
