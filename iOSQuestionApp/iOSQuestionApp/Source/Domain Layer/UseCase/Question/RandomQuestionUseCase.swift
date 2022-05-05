//
//  RandomQuestionUseCase.swift
//  iOSQuestionApp
//
//  Created by Woody on 2022/05/05.
//

import Foundation
import Combine

final class RandomQuestionUseCase {
    private let questionRepository: QuestionRepositoryProtocol

    let randomQuestion = PassthroughSubject<Question, Never>()
    
    init(_ questionRepository: QuestionRepositoryProtocol) {
        self.questionRepository = questionRepository
    }
}

extension RandomQuestionUseCase {
    func requestRandomQuestion() {
        let question = questionRepository.getRandomQuestion() ?? Question.Empty
        randomQuestion.send(question)
    }
}
