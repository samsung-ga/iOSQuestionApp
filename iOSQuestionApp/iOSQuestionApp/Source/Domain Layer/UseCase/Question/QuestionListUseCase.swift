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
    typealias QuestionList = [Question]
    typealias QuestionInfoList = [QuestionInfo]
    
    let questionList = CurrentValueSubject<QuestionInfoList, Never>([])
    
    init(_ questionRepository: QuestionRepositoryProtocol,
         _ answerRepository: AnswerRepositoryProtocol) {
        self.questionRepository = questionRepository
        self.answerRepository = answerRepository
    }
}

extension QuestionListUseCase {
    
    func requestQuestionListInformation() {
        let questions = questionRepository.getQuestionsAnswered()
        let questionsConverted = convertType(questions)
        questionList.send(alignAnswerListByDate(questionsConverted))
    }
    
    private func convertType(_ questions: QuestionList) -> QuestionInfoList {
        var questionInfos = QuestionInfoList()
        questions.forEach {
            let answers = answerRepository.getAnswer(of: $0)
            let newestDate = compareDate(answers)
            let questionInfo = QuestionInfo(question: $0,
                                    answerCount: answers.count,
                                    answerDate: newestDate)
            questionInfos.append(questionInfo)
        }
        return questionInfos
    }
    
    private func compareDate(_ answers: [Answer]) -> DateString {
        if answers.isEmpty { return "" }
        var newest: Date =  answers[0].date.convertStringToDate()
        answers.forEach {
            newest = max(newest, $0.date.convertStringToDate())
        }
        return newest.convertDateToString()
    }
    
    private func alignAnswerListByDate(_ questions: QuestionInfoList) -> QuestionInfoList {
        return questions.sorted { first, second in
            let firstDate = first.answerDate.convertStringToDate()
            let secondDate = second.answerDate.convertStringToDate()
            return firstDate - secondDate > 0
        }
    }
}
