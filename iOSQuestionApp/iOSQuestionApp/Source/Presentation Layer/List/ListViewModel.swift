//
//  ListViewModel.swift
//  iOSQuestionApp
//
//  Created by Woody on 2022/05/05.
//

import Foundation
import Combine

final class ListViewModel: BaseViewModel {
    private let questionStatisticUseCase: QuestionStatisticUseCase
    private let questionListUseCase: QuestionListUseCase
    private let answerNumberUseCase: AnswerNumberUseCase
    // input
    let viewWillAppear = PassthroughSubject<Void, Never>()
    // output
    let tableViewReload = PassthroughSubject<Void, Never>()
    
    var count: Int = 1 + 0
    var questionList: [QuestionCellViewModel] = []
    var statistics: StatisticCellModel?
    
    init(_ questionStatisticUseCase: QuestionStatisticUseCase,
         _ questionListUseCase: QuestionListUseCase,
         _ answerNumberUseCase: AnswerNumberUseCase
    ) {
        self.questionStatisticUseCase = questionStatisticUseCase
        self.questionListUseCase = questionListUseCase
        self.answerNumberUseCase = answerNumberUseCase
        super.init()
        transform()
    }
    
    private func transform() {
        viewWillAppear.sink { [weak self] _ in
            self?.answerNumberUseCase.requestAnswerNumber()
            self?.questionStatisticUseCase.requestQuestions()
            self?.questionListUseCase.requestQuestionListInformation()
        }
        .store(in: &cancelBag)
        
        questionStatisticUseCase.questionCategory
            .combineLatest(answerNumberUseCase.answerNumber)
            .map { StatisticCellModel(answerCount: $0.1, counts: $0.0) }
            .sink { [weak self] in
                self?.statistics = $0
                self?.tableViewReload.send(Void())
            }
            .store(in: &cancelBag)
        
        // TODO: 리팩토링 필요해요. 물어보기
        // ([A],[B],[C]) -> [D(A,B,C)]
        questionListUseCase.questionList
            .sink { [weak self] tuple in
                let questions = tuple.0
                let answerCounts = tuple.1
                let dates = tuple.2
                self?.count = 1 + questions.count
                
                var questionInfo: [QuestionCellViewModel] = []
                questions.enumerated().forEach { (index, question) in
                    let temp = QuestionCellViewModel(question: question,
                                                     answerCount: answerCounts[index],
                                                     answerDate: dates[index])
                    questionInfo.append(temp)
                }
                self?.questionList = self?.alignAnswerListByDate(questionInfo) ?? []
                self?.tableViewReload.send(Void())
            }
            .store(in: &cancelBag)
        
        
    }
    
    private func alignAnswerListByDate(_ questions: [QuestionCellViewModel]) -> [QuestionCellViewModel] {
        return questions.sorted { first, second in
            let firstDate = first.answerDate.convertStringToDate()
            let secondDate = second.answerDate.convertStringToDate()
            return firstDate - secondDate > 0
        }
    }
    
    func getQuestionListModel(to indexPath: IndexPath) -> QuestionCellViewModel {
        return questionList[indexPath.row - 1]
    }
}
