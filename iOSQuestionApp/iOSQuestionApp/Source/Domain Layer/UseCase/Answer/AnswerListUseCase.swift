//
//  AnswerListUseCase.swift
//  iOSQuestionApp
//
//  Created by Woody on 2022/05/06.
//

import Foundation
import Combine

final class AnswerListUseCase {
    private let answerRepository: AnswerRepositoryProtocol
    
    typealias AnswerList = [Answer]
    
    let answerList = PassthroughSubject<AnswerList, Never>()
    
    init(_ answerRepository: AnswerRepositoryProtocol) {
        self.answerRepository = answerRepository
    }
}

extension AnswerListUseCase {
    
    func requestAnswerList(_ question: Question) {
        let answers = answerRepository.getAnswer(of: question)
        answerList.send(answers)
    }
    
    // 정렬 ㅠㅠㅠ 이거 여기서 해줘야하냐 ㅠㅠ
}
