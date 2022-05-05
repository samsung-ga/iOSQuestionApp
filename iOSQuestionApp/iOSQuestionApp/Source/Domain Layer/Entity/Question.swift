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
    
    static let dummy: [Question] = [
        Question(id: 1, content: "Class와 Struct의 차이점은?", isAnswered: true, category: .iOS),
        Question(id: 1, content: "하나의 View Controller 코드에서 여러 TableView Controller 역할을 해야 할 경우 어떻게 구분해서 구현해야 하는지 설명하시오.", isAnswered: true, category: .Architecture),
        Question(id: 1, content: "Class와 Struct의 차이점은?", isAnswered: true, category: .iOS),
        Question(id: 1, content: "하나의 View Controller 코드에서 여러 TableView Controller 역할을 해야 할 경우 어떻게 구분해서 구현해야 하는지 설명하시오.", isAnswered: true, category: .Architecture),
        Question(id: 1, content: "Class와 Struct의 차이점은?", isAnswered: true, category: .iOS),
        Question(id: 1, content: "하나의 View Controller 코드에서 여러 TableView Controller 역할을 해야 할 경우 어떻게 구분해서 구현해야 하는지 설명하시오.", isAnswered: true, category: .Architecture),
        Question(id: 1, content: "Class와 Struct의 차이점은?", isAnswered: true, category: .iOS),
        Question(id: 1, content: "하나의 View Controller 코드에서 여러 TableView Controller 역할을 해야 할 경우 어떻게 구분해서 구현해야 하는지 설명하시오.", isAnswered: true, category: .Architecture),
        Question(id: 1, content: "Class와 Struct의 차이점은?", isAnswered: true, category: .iOS),
        Question(id: 1, content: "하나의 View Controller 코드에서 여러 TableView Controller 역할을 해야 할 경우 어떻게 구분해서 구현해야 하는지 설명하시오.", isAnswered: true, category: .Architecture)
    ]
}
