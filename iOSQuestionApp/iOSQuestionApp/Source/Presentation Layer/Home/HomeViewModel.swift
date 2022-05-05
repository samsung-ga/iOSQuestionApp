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
    
    // input
    let viewWillAppear = PassthroughSubject<Void, Never>()
    // output
    let answerNumber = PassthroughSubject<Int, Never>()

    init(_ answerNumberUseCase: AnswerNumberUseCase) {
        self.answerNumberUseCase = answerNumberUseCase
        super.init()
        transform()
    }
    
    private func transform() {
        // input
        viewWillAppear.sink { [weak self] _ in
            self?.answerNumberUseCase.requestAnswerNumber()
        }
        .store(in: &cancelBag)
        
        // connect to usecase
        answerNumberUseCase.answerNumber.sink { [weak self] number in
            self?.answerNumber.send(number)
        }
        .store(in: &cancelBag)
    }
}
