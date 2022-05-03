//
//  Question.swift
//  iOSQuestionApp
//
//  Created by Woody on 2022/05/02.
//

import Foundation

struct Question: Hashable {
    var id: Int
    var content: String
    var isAnswered: Bool
}

extension Question {
    static let Empty = Question(id: -1, content: "질문을 뽑아오지 못했습니다.", isAnswered: false)
}
