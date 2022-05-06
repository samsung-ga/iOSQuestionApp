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
    
    static let dummy: [Answer] = [
        Answer(id: 1, questionID: 1, content: "잘 모르겠어요 ㅠㅠ", date: "2022-05-04"),
        Answer(id: 1, questionID: 1, content: "가장 큰 차이점으로는 클래스는 레퍼런스타입과 스트럭은 값타입이라는 점입니다. 이 뜻은 같은 클래스 인스턴스를 여러 개의 변수에 할당하고 값을 변경하면 모든 변수에 영향을 주지만 스트럭의 경우 새로운 변수에 할당할 때마다 새로운 구조체가 생성이 됩니다. \n 다음 차이점으로는 상속이 있습니다…. \n\n대충 답변 ", date: "2022-05-05")
    ]
}
