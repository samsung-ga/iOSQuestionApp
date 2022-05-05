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
        formatter.locale = .init(identifier: "ko")
        formatter.dateFormat = "M월 d일 a H:m:s"
        return formatter.date(from: self) ?? .now
    }
    
    func subStringDate() -> String {
        return String(self.prefix(16))
    }
}
