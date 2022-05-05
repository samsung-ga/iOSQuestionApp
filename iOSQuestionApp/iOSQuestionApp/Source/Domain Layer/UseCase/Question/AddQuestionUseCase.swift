//
//  AddQuestionUseCase.swift
//  iOSQuestionApp
//
//  Created by Woody on 2022/05/05.
//

import Foundation

final class AddQuestionUseCase {
    private let questionRepository: QuestionRepositoryProtocol
    
    init(_ questionRepository: QuestionRepositoryProtocol) {
        self.questionRepository = questionRepository
    }
}

extension AddQuestionUseCase {
    private func insertQuestions() {
        questionRepository
    }
}
