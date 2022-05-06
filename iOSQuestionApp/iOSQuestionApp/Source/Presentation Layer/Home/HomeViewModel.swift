//
//  HomeViewModel.swift
//  iOSQuestionApp
//
//  Created by Woody on 2022/05/05.
//

import Foundation
import Combine

final class HomeViewModel: BaseViewModel {
    private let answerNumberUseCase: AnswerNumberUseCase
    private let answerExistenceUseCase: AnswerExistenceUseCase
    
    // input
    let viewWillAppear = PassthroughSubject<Void, Never>()
    // output
    let answerNumber = PassthroughSubject<Int, Never>()
    let homeState = PassthroughSubject<HomeState, Never>()
    
    init(_ answerNumberUseCase: AnswerNumberUseCase,
         _ answerExistenceUseCase: AnswerExistenceUseCase) {
        self.answerNumberUseCase = answerNumberUseCase
        self.answerExistenceUseCase = answerExistenceUseCase
        super.init()
        transform()
    }
    
    private func transform() {
        // input
        viewWillAppear.sink { [weak self] _ in
            self?.answerNumberUseCase.requestAnswerNumber()
            self?.answerExistenceUseCase.requestHomeState()
        }
        .store(in: &cancelBag)
        
        // connect to usecase
        answerNumberUseCase.answerNumber
            .sink { [weak self] number in
                self?.answerNumber.send(number)
            }
            .store(in: &cancelBag)
        
        answerExistenceUseCase.homeState
            .sink { [weak self] state in
                self?.homeState.send(state)
            }
            .store(in: &cancelBag)
    }
}
