//
//  SettingViewModel.swift
//  iOSQuestionApp
//
//  Created by Woody on 2022/05/05.
//

import Foundation

class SettingViewModel {
    
    private let settings: [String] = ["오픈 소스 라이브러리", "질문 출처"]
    
    var count: Int {
        return settings.count
    }
    
    func settingTitleString(at indexPath: IndexPath) -> String {
        return settings[indexPath.row]
    }
}
