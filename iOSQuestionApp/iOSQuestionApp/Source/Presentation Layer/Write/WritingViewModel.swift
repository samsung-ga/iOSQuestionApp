//
//  WritingViewModel.swift
//  iOSQuestionApp
//
//  Created by Woody on 2022/05/05.
//

import Foundation
import Combine

final class WritingViewModel: BaseViewModel {
    private let randomQuestionUseCase: RandomQuestionUseCase
    private let writeAnswerUseCase: WriteAnswerUseCase
    
    // input
    let viewWillAppear = PassthroughSubject<Void, Never>()
    let textViewChanged = PassthroughSubject<String, Never>()
    let completButtonPressed = PassthroughSubject<(String), Never>()
    // output
    let questionContent = PassthroughSubject<String, Never>()
    let textViewCondition = PassthroughSubject<Bool, Never>()
    let textCount = PassthroughSubject<Int, Never>()
    let storeCompleted = PassthroughSubject<Bool, Never>()
    
    var question: Question?
    
    init(_ question: Question?,
        _ randomQuestionUseCase: RandomQuestionUseCase,
         _ writeAnswerUseCase: WriteAnswerUseCase) {
        self.question = question
        self.randomQuestionUseCase = randomQuestionUseCase
        self.writeAnswerUseCase = writeAnswerUseCase
        super.init()
        transform()
    }
    
    private func transform() {
        viewWillAppear.sink { [weak self] _ in
            if self?.question == nil {
                self?.randomQuestionUseCase.requestRandomQuestion()
            }
        }
        .store(in: &cancelBag)
        
        textViewChanged.sink { [weak self] text in
            guard let self = self else { return }
            let count = self.calculateTextCount(text)
            self.textViewCondition.send(count <= 600)
            self.textCount.send(count)
        }
        .store(in: &cancelBag)
        
        completButtonPressed.sink { [weak self] in
            guard let question = self?.question else { return }
            self?.writeAnswerUseCase.storeAnswer($0, to: question)
        }
        .store(in: &cancelBag)
        
        // connect to UseCase
        randomQuestionUseCase.randomQuestion
            .sink { [weak self] in
                self?.question = $0
                self?.questionContent.send($0.content)
            }
            .store(in: &cancelBag)
        
        writeAnswerUseCase.storeAnswerResult
            .sink { [weak self] in
                self?.storeCompleted.send($0)
            }
            .store(in: &cancelBag)
        
    }
    
    private func calculateTextCount(_ text: String) -> Int {
        return text.count
    }
}
