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
    
    func updateQuestion(_ question: Question) {
        _ = questionTable.updateRow(question)
    }
    
    // TODO: 질문을 어떤 식으로 집어넣을 지도 고민해보아야 함. JSON을 통째로 교체하면 절대로 안됌(답변여부를 체크해서 넣어야함)
    func insertQuestions(_ questions: [Question]) {
        questions.forEach {
            _ = questionTable.insertRow($0)
        }
    }
}
