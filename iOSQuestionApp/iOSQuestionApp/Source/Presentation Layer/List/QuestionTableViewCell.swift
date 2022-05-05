//
//  QuestionTableViewCell.swift
//  iOSQuestionApp
//
//  Created by Woody on 2022/05/05.
//

import UIKit

struct QuestionCellViewModel {
    let answerDate: String
    let questionContent: String
    let questionCategory: QuestionCategory
    let answerCount: String
}

class QuestionTableViewCell: BaseTableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var categoryContainerView: UIView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var answerCountContainerView: UIView!
    @IBOutlet weak var answerCountLabel: UILabel!
    
    override func setupAttribute() {
        super.setupAttribute()
        
        containerView.makeCorenerRadius(26)
        let radius: CGFloat = categoryContainerView.frame.height/2
        categoryContainerView.makeCorenerRadius(radius)
        answerCountContainerView.makeCorenerRadius(radius)
    }
    
    func configure(with viewModel: QuestionCellViewModel) {
        dateLabel.text = viewModel.answerDate
        questionLabel.text = viewModel.questionContent
        categoryLabel.text = viewModel.questionCategory.rawValue
        answerCountLabel.text = "\(viewModel.answerCount)"
    }
}
