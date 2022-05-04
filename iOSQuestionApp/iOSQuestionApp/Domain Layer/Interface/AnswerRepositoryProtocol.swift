//
//  AnswerRepositoryProtocol.swift
//  iOSQuestionApp
//
//  Created by Woody on 2022/05/02.
//

import Foundation

protocol AnswerRepositoryProtocol {
    func saveAnswer(_ answer: Answer)
    func getAnswer(of question: Question) -> [Answer]
}
