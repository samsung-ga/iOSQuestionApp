//
//  Question.swift
//  iOSQuestionApp
//
//  Created by Woody on 2022/05/02.
//

import Foundation

enum QuestionCategory: String {
    case iOS
    case Swift
    case SwiftUI
    case Advanced
    case Architecture
    case Programming
    case None
    
    static func changeToEnum(_ string: String) -> Self {
        return .init(rawValue: string)!
    }
}

struct Question: Hashable {
    var id: Int
    var content: String
    var isAnswered: Bool
    var category: QuestionCategory
}

extension Question {
    static let Empty = Question(id: -1, content: "질문을 뽑아오지 못했습니다.", isAnswered: false, category: .None)
}
