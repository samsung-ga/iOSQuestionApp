//
//  StatisticTableViewCell.swift
//  iOSQuestionApp
//
//  Created by Woody on 2022/05/05.
//

import UIKit

struct StatisticCellModel {
    let answerCount: Int
    let counts: [QuestionCategory: Int]
}
final class StatisticTableViewCell: BaseTableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var answerCountLabel: UILabel!
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
        answerCountLabel.text = "총 \(cellViewModel.answerCount)번 답변하셨네요!"
        swiftCountLabel.text = "\(cellViewModel.counts[.Swift] ?? 0)"
        iOSCountLabel.text = "\(cellViewModel.counts[.iOS] ?? 0)"
        swiftUICountLabel.text = "\(cellViewModel.counts[.SwiftUI] ?? 0)"
        architectureCountLabel.text = "\(cellViewModel.counts[.Architecture] ?? 0)"
        advancedCountLabel.text = "\(cellViewModel.counts[.Advanced] ?? 0)"
        programmingCountLabel.text = "\(cellViewModel.counts[.Programming] ?? 0)"
    }
}
