//
//  StatisticTableViewCell.swift
//  iOSQuestionApp
//
//  Created by Woody on 2022/05/05.
//

import UIKit

struct StatisticCellModel {
    let questionCount: Int
    let swiftCount: Int
    let iOSCount: Int
    let swiftUICount: Int
    let architectureCount: Int
    let advancedCount: Int
    let programmingCount: Int
    
}
final class StatisticTableViewCell: BaseTableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var swiftCountLabel: UILabel!
    @IBOutlet weak var iOSCountLabel: UILabel!
    @IBOutlet weak var swiftUICountLabel: UILabel!
    @IBOutlet weak var architectureCountLabel: UILabel!
    @IBOutlet weak var advancedCountLabel: UILabel!
    @IBOutlet weak var programmingCountLabel: UILabel!
    
    override func setupAttribute() {
        super.setupAttribute()
        
        containerView.makeCorenerRadius(26)
    }
    
    func configure(with cellViewModel: StatisticCellModel) {
        swiftCountLabel.text = "\(cellViewModel.swiftCount)"
        iOSCountLabel.text = "\(cellViewModel.iOSCount)"
        swiftUICountLabel.text = "\(cellViewModel.swiftUICount)"
        architectureCountLabel.text = "\(cellViewModel.architectureCount)"
        advancedCountLabel.text = "\(cellViewModel.advancedCount)"
        programmingCountLabel.text = "\(cellViewModel.programmingCount)"
    }
}
