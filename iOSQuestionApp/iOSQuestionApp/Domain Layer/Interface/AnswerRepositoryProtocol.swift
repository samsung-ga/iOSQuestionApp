//
//  AnswerRepositoryProtocol.swift
//  iOSQuestionApp
//
//  Created by Woody on 2022/05/02.
//

import Foundation

// TODO: 도메인 내 모델 Requeset Response 형태로 수정 필요
protocol AnswerRepositoryProtocol {
    func setAnsweredToday(_ direction: Bool)
    func saveAnswer(in question: Question)
}
