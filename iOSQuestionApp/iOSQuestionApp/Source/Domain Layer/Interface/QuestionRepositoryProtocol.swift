//
//  QuestionRepositoryProtocol.swift
//  iOSQuestionApp
//
//  Created by Woody on 2022/05/02.
//

import Foundation

protocol QuestionRepositoryProtocol {
    func getRandomQuestion() -> Question?
    func getQuestionsAnswered() -> [Question]
    func updateQuestion(_ question: Question)
    func insertQuestions(_ questions: [Question])
}
