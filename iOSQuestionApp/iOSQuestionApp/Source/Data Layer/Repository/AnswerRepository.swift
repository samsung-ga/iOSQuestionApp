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
    
    func saveAnswer(_ answer: Answer, completion: (Bool)-> Void) {
        let result = answerTable.insertRow(answer) ?? false
        completion(result)
    }
    
    func getAnswerCount() -> Int {
        if let answers = answerTable.getRow() {
            return answers.count
        }
        return 0
    }
    func getAnswer(of question: Question) -> [Answer] {
        if let answers = answerTable.getRow() {
            return answers.filter { $0.questionID == question.id }
        }
        return []
    }
}
