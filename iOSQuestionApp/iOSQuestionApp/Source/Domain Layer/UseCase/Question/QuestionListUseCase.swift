//
//  QuestionListUseCase.swift
//  iOSQuestionApp
//
//  Created by Woody on 2022/05/02.
//

import Foundation
import Combine

final class QuestionListUseCase {
    private let questionRepository: QuestionRepositoryProtocol
    private let answerRepository: AnswerRepositoryProtocol

    typealias QuestionListInformation = [Question: Int]
    
    let questionList = CurrentValueSubject<QuestionListInformation, Never>([:])
    
    init(_ questionRepository: QuestionRepositoryProtocol,
         _ answerRepository: AnswerRepositoryProtocol) {
        self.questionRepository = questionRepository
        self.answerRepository = answerRepository
    }
}

extension QuestionListUseCase {
    func requestQuestionListInformation() {
        var questionListInfo = [Question:Int]()
        let questions = questionRepository.getQuestionsAnswered()
        questions.forEach {
            let answers = answerRepository.getAnswer(of: $0)
            questionListInfo[$0] = 0
        }
        
    }
}
