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
