//
//  QuestionTableViewCell.swift
//  iOSQuestionApp
//
//  Created by Woody on 2022/05/05.
//

import UIKit

struct QuestionCellViewModel {
    let question: Question
    let answerCount: Int
    let answerDate: String
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
        dateLabel.text = viewModel.answerDate.subStringDate()
        questionLabel.text = viewModel.question.content
        categoryLabel.text = viewModel.question.category.rawValue
        answerCountLabel.text = "\(viewModel.answerCount)"
    }
}
