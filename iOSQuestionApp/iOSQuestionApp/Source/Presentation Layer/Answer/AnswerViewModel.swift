//
//  AnswerViewModel.swift
//  iOSQuestionApp
//
//  Created by Woody on 2022/05/06.
//

import Foundation
import Combine

final class AnswerViewModel: BaseViewModel {
    private let answerListUseCase: AnswerListUseCase
    
    // input
    let viewWillAppear = PassthroughSubject<Void, Never>()
    // output
    let collectionViewReload = PassthroughSubject<Void, Never>()
    
    var count: Int = 0
    var question: Question
    var answers: [AnswerCellViewModel] = []
    init(_ question: Question,
         _ answerListUseCase: AnswerListUseCase
         ) {
        self.question = question
        self.answerListUseCase = answerListUseCase
        super.init()
        transform()
    }
    
    private func transform() {
        viewWillAppear.sink { [weak self] _ in
            guard let self = self else { return }
            self.answerListUseCase.requestAnswerList(self.question)
        }
        .store(in: &cancelBag)
        
        answerListUseCase.answerList
            .sink { [weak self] answerList in
                self?.answers = answerList.map { AnswerCellViewModel.init(answer: $0) }
                self?.count = answerList.count
                self?.collectionViewReload.send(Void())
            }
            .store(in: &cancelBag)
    }
    
    func getAnswerCellViewModel(to indexPath: IndexPath) -> AnswerCellViewModel {
        return answers[indexPath.row]
    }
}
