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
        // TODO: 성공여부를 없앨까? 이런코드 짜증나.
        _ = answerTable.insertRow(answer)
    }
    
    func getAnswer(of question: Question) -> [Answer] {
        // TODO: 이것도 비즈니스로직일까? 서버에서 정렬해서 주면 되는건데 로컬 디비를 이용하니까 이런 고민까지 해야하는구나 .
        if let answers = answerTable.getRow() {
            return answers.filter { $0.questionID == question.id }
        }
        return []
    }
}
