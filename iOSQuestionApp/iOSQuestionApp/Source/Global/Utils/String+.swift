//
//  String+.swift
//  iOSQuestionApp
//
//  Created by Woody on 2022/05/06.
//

import Foundation

extension String {
    func convertStringToDate() -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM월 dd일"
        
        return formatter.date(from: self) ?? .now
    }
}
