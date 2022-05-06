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
    
    typealias DateString = String
    typealias AnswerCount = Int
    typealias QuestionListInformation = ([Question],[AnswerCount],[DateString])
    
    let questionList = CurrentValueSubject<QuestionListInformation, Never>(([],[],[]))
    
    init(_ questionRepository: QuestionRepositoryProtocol,
         _ answerRepository: AnswerRepositoryProtocol) {
        self.questionRepository = questionRepository
        self.answerRepository = answerRepository
    }
}

extension QuestionListUseCase {
    
    func requestQuestionListInformation() {
        var answerCounts = [AnswerCount]()
        var dateStrings = [DateString]()
        let questions = questionRepository.getQuestionsAnswered()
        questions.forEach {
            let answers = answerRepository.getAnswer(of: $0)
            let newestDate = compareDate(answers)
            answerCounts.append(answers.count)
            dateStrings.append(newestDate)
        }
        questionList.send((questions, answerCounts, dateStrings))
    }
    
    private func compareDate(_ answers: [Answer]) -> DateString {
        if answers.isEmpty { return "" }
        var newest: Date =  answers[0].date.convertStringToDate()
        answers.forEach {
            newest = max(newest, $0.date.convertStringToDate())
        }
        return newest.convertDateToString()
    }
}
