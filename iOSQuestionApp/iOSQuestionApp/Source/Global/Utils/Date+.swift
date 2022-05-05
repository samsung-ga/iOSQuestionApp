//
//  Date+.swift
//  iOSQuestionApp
//
//  Created by Woody on 2022/05/05.
//

import Foundation

extension Date {
    
    func convertDateToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .init(identifier: "ko")
        dateFormatter.dateFormat = "M월 dd일 a H:m:s"
        return dateFormatter.string(from: self)
    }
    
    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }
}

