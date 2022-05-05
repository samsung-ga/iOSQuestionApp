//
//  TodayAnswerRepository.swift
//  iOSQuestionApp
//
//  Created by Woody on 2022/05/03.
//

import Foundation

final class TodayAnswerRepository: TodayAnsweredRepositoryProtocol {
    func isAnsweredToday() -> Bool {
        return UserDefaults.standard.bool(forKey: UserDefaultKeyName.todayAnswered.rawValue)
    }
    
    func saveAnsweredToday() {
        UserDefaults.standard.set(true, forKey: UserDefaultKeyName.todayAnswered.rawValue)
    }
    
    func resetAnswredToday() {
        UserDefaults.standard.set(false, forKey: UserDefaultKeyName.todayAnswered.rawValue)
    }
}
