//
//  AnswerCollectionViewCell.swift
//  iOSQuestionApp
//
//  Created by Woody on 2022/05/05.
//

import UIKit

class AnswerCollectionViewCell: BaseCollectionViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    override func setupAttribute() {
        super.setupAttribute()
        
        self.makeCorenerRadius(26)
        // TODO: text가 지정된 후에 다시 불러주어야 하는 함수 (지금은 테스트용)
        contentLabel.setupLineSpacing(4)
    }
    
}
