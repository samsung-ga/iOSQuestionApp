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
        // [A] -> [B]
        questionListUseCase.questionList
            .sink { [weak self] infos in
                var questionInfo: [QuestionCellViewModel] = []
                infos.forEach {
                    let question = QuestionCellViewModel(question: $0.question,
                                                         answerCount: $0.answerCount,
                                                         answerDate: $0.answerDate)
                    questionInfo.append(question)
                }
                self?.questionList = questionInfo
                self?.count = 1 + (self?.questionList.count ?? 0) // MARK: 이거 불편함 테이블뷰 바인딩처리.. 컴바인에서는 어디없나
                self?.tableViewReload.send(Void())
            }
            .store(in: &cancelBag)
    }
    
    func getQuestionListModel(to indexPath: IndexPath) -> QuestionCellViewModel {
        return questionList[indexPath.row - 1]
    }
}
