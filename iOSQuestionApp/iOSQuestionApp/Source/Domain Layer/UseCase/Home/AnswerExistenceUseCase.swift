//
//  IsTodayAnswerUseCase.swift
//  iOSQuestionApp
//
//  Created by Woody on 2022/05/02.
//

import Foundation
import Combine

enum HomeState {
    case notAnswered
    case answered
}

final class AnswerExistenceUseCase {
    private let todayAnsweredRepository: TodayAnswerRepositoryProtocol
    
    let homeState = CurrentValueSubject<HomeState, Never>(.notAnswered)
    
    init(_ todayAnsweredRepository: TodayAnswerRepositoryProtocol) {
        self.todayAnsweredRepository = todayAnsweredRepository
    }
}

extension AnswerExistenceUseCase {
    
    func requestHomeState() {
        let isAnswered: Bool = todayAnsweredRepository.isAnsweredToday()
        homeState.send(isAnswered ? .answered : .notAnswered)
    }
}
