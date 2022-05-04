//
//  GetQuestionStatisticUseCase.swift
//  iOSQuestionApp
//
//  Created by Woody on 2022/05/02.
//

import Foundation
import Combine

final class QuestionStatisticUseCase {
    private let questionRepository: QuestionRepositoryProtocol
    
    typealias QuestionCategoryDictionary = [QuestionCategory: Int]
    
    let questionCategory = CurrentValueSubject<QuestionCategoryDictionary, Never>([:])
    
    init(_ questionRepository: QuestionRepositoryProtocol) {
        self.questionRepository = questionRepository
    }
}

extension QuestionStatisticUseCase {
    
    func requestQuestions() {
        let questionsAnswered = questionRepository.getQuestionsAnswered()
        var dictionary:[QuestionCategory: Int] = [:]
        questionsAnswered.forEach {
            let count: Int = dictionary[$0.category]!
            dictionary[$0.category] = count + 1
        }
        questionCategory.send(dictionary)
    }
}
