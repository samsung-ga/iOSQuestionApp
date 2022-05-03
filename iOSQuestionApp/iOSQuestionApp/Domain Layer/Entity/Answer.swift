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
    var date: String
}

extension Answer {
    static let Empty = Answer(id: -1, questionID: -1, content: "질문이 비었습니다.", date: "")
}
