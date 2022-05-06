//
//  TodayAnsweredRepositoryProtocol.swift
//  iOSQuestionApp
//
//  Created by Woody on 2022/05/02.
//

import Foundation

protocol TodayAnswerRepositoryProtocol {
    func isAnsweredToday() -> Bool
    func saveAnsweredToday()
    func resetAnswredToday()
}
