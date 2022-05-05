//
//  WriteAnswerUseCase.swift
//  iOSQuestionApp
//
//  Created by Woody on 2022/05/02.
//

import Foundation
import Combine

final class WriteAnswerUseCase {
    private let answerRepository: AnswerRepositoryProtocol
    private let questionRepository: QuestionRepositoryProtocol
    
    let storeAnswerResult = PassthroughSubject<Bool, Never>()
    
    init(_ answerRepository: AnswerRepositoryProtocol,
         _ questionRepository: QuestionRepositoryProtocol) {
        self.answerRepository = answerRepository
        self.questionRepository = questionRepository
    }
}

extension WriteAnswerUseCase {
    func storeAnswer(_ answer: String, to question: Question) {
        // 빈 답변 것 실패
        guard !answer.isEmpty else {
            storeAnswerResult.send(false)
            return
        }
        let question = updateQuestionAnswered(question)
        questionRepository.updateQuestion(question)
        
        let date = Date(timeIntervalSinceNow: 0).convertDateToString()
        let answerModel = Answer(id: 0,
                                 questionID: question.id,
                                 content: answer,
                                 date: date)
        
        answerRepository.saveAnswer(answerModel) { result in
            storeAnswerResult.send(result)
        }
    }
    
    private func updateQuestionAnswered(_ question: Question) -> Question {
        var question = question
        question.isAnswered = true
        return question
    }
    
    private func createAnswerModel() {
        
    }
}
