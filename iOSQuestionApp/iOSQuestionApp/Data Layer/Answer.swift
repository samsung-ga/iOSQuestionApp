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
