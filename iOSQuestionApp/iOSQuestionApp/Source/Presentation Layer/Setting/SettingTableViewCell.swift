//
//  SettingTableViewCell.swift
//  iOSQuestionApp
//
//  Created by Woody on 2022/05/05.
//

import UIKit

class SettingTableViewCell: BaseTableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func setupAttribute() {
        containerView.makeCorenerRadius(26)    
    }
    
    func configure(item: String) {
        titleLabel.text = item
    }
}
