//
//  AnswerRepository.swift
//  iOSQuestionApp
//
//  Created by Woody on 2022/05/03.
//

import Foundation

final class AnswerRepository {
    
    let answerTable: AnswerTableProtocol
    
    init() {
        self.answerTable = AnswerTable()
        answerTable.createTable()
    }
}

extension AnswerRepository: AnswerRepositoryProtocol {
    
    func saveAnswer(_ answer: Answer) {
        _ = answerTable.insertRow(answer)
    }
    
    func getAnswer(of question: Question) -> [Answer] {
        if let answers = answerTable.getRow() {
            return answers.filter { $0.questionID == question.id }
        }
        return []
    }
}
