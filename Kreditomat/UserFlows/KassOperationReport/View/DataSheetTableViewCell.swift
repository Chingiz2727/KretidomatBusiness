//
//  DataSheetTableViewCell.swift
//  Kreditomat
//
//  Created by Чингиз Куандык on 11.05.2021.
//

import UIKit
import SpreadsheetView

class DataSheetTableViewCell: Cell {

    let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { $0.edges.equalToSuperview().inset(5) }
        titleLabel.font = .systemFont(ofSize: 9)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
