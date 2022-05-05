//
//  UITableView+.swift
//  iOSQuestionApp
//
//  Created by Woody on 2022/05/05.
//

import UIKit

extension UITableView {
    
    func registerWithNib<TableViewCell: UITableViewCell>(_ cellType: TableViewCell.Type) {
        let cellName = String(describing: cellType)
        let nibData = UINib(nibName: String(describing: cellName), bundle: nil)
        self.register(nibData, forCellReuseIdentifier: cellName)
    }
    
    func dequeueReusableCell<TableViewCell: UITableViewCell>(_ cellType: TableViewCell.Type, for indexPath: IndexPath) -> TableViewCell? {
        let identifier = String(describing: cellType)
        return self.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? TableViewCell
    }
}
