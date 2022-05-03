//
//  Answer.swift
//  iOSQuestionApp
//
//  Created by Woody on 2022/05/02.
//

import Foundation

struct Answer: Hashable {
    var id: Int
    var questionID: Int
    var content: String
    var date: Date
}

extension Answer {
    static let Empty = Question(id: -1, content: "저장된 답변이 없습니다.", isAnswered: false)
}
