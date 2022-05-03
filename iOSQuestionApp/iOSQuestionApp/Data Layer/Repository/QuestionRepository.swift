//
//  QuestionRepository.swift
//  iOSQuestionApp
//
//  Created by Woody on 2022/05/03.
//

import Foundation

final class QuestionRepository {
    let questionTable: QuestionTableProtocol
    
    init() {
        self.questionTable = QuestionTable()
        questionTable.createTable()
    }
    
}

// TODO: 쿼리로직이 Repository에 들어가게 되는 문제점
extension QuestionRepository: QuestionRepositoryProtocol {
    
    func getRandomQuestion() -> Question? {
        if let questions = questionTable.getRow() {
            return questions.filter { $0.isAnswered == false }.randomElement()
        }
        return nil
    }
    
    func getQuestionsAnswered() -> [Question] {
        if let questions = questionTable.getRow() {
            return questions.filter { $0.isAnswered == true }
        }
        return []
    }
    
}
