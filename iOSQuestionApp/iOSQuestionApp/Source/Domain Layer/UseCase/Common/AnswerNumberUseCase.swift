//
//  QuestionUseCase.swift
//  iOSQuestionApp
//
//  Created by Woody on 2022/05/02.
//

import Foundation
import Combine

class AnswerNumberUseCase {
    private let questionRepository: QuestionRepositoryProtocol
    
    let answerNumber = CurrentValueSubject<Int, Never>(0)
    
    init(questionRepository: QuestionRepositoryProtocol) {
        self.questionRepository = questionRepository
    }
}

extension AnswerNumberUseCase {
    
    func requestAnswerNumber() {
        let questions = questionRepository.getQuestionsAnswered()
        answerNumber.send(questions.count)
    }
}
