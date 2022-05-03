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

extension QuestionRepository: QuestionRepositoryProtocol {
    
    // TODO: 비즈니스 로직으로 처리할까? 나중에 고민해보자... 근데 진짜 로직이 간단해서 구분하기가 오히려 더 어렵다 ㅠ ㅠ
    func getRandomQuestion() -> Question? {
        if let questions = questionTable.getRow() {
            return questions.filter { $0.isAnswered == false }.randomElement()
        }
        return nil
    }
    
    // TODO: 비즈니스 로직에서 최근에 답한 질문들부터 위에 오도록 정렬해주어야한다. 그러기위해선 답변들도 함께 뽑아야함.
    func getQuestionsAnswered() -> [Question] {
        if let questions = questionTable.getRow() {
            return questions.filter { $0.isAnswered == true }
        }
        return []
    }
    
    // TODO: 질문을 어떤 식으로 집어넣을 지도 고민해보아야 함. JSON을 통째로 교체하면 절대로 안됌(답변여부를 체크해서 넣어야함)
}
