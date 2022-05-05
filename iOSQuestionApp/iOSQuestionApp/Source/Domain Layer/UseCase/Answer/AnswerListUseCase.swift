//
//  AnswerListUseCase.swift
//  iOSQuestionApp
//
//  Created by Woody on 2022/05/06.
//

import Foundation
import Combine

final class AnswerListUseCase {
    private let answerRepository: AnswerRepositoryProtocol
    
    typealias AnswerList = [Answer]
    
    let answerList = PassthroughSubject<AnswerList, Never>()
    
    init(_ answerRepository: AnswerRepositoryProtocol) {
        self.answerRepository = answerRepository
    }
}

extension AnswerListUseCase {
    
    func requestAnswerList(_ question: Question) {
        var answers = answerRepository.getAnswer(of: question)
        answers = alignAnswers(answers)
        answerList.send(answers)
    }
    
    private func alignAnswers(_ answers: AnswerList) -> AnswerList {
        return answers.sorted { first, second in
            let firstDate = first.date.convertStringToDate()
            let secondDate = second.date.convertStringToDate()
            return firstDate - secondDate > 0
        }
    }
}
