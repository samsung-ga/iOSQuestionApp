//
//  ListViewController.swift
//  iOSQuestionApp
//
//  Created by Woody on 2022/05/05.
//

import UIKit

final class ListViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    var viewModel: ListViewModel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear.send(Void())
    }
    
    override func setupAttribute() {
        super.setupAttribute()
        
        self.navigationItem.title = "답변 목록"
        
        tableView.backgroundColor = Pallete.main.color
        tableView.registerWithNib(StatisticTableViewCell.self)
        tableView.registerWithNib(QuestionTableViewCell.self)
    }
    
    override func bind() {
        viewModel.tableViewReload
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
        .store(in: &cancelBag)
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // TODO: question 배열의 엠티 유무에 따라서 판단해야한다.
        if indexPath.row == 0 {
            return statisticCell(for: indexPath)
        } else {
            return questionCell(for: indexPath)
        }
        
    }
    
    private func statisticCell(for indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(StatisticTableViewCell.self,
                                                       for: indexPath) else {
            fatalError()
        }
        guard let model = viewModel.statistics else { return cell }
        cell.configure(with: model)
        return cell
    }
    
    private func questionCell(for indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(QuestionTableViewCell.self,
                                                       for: indexPath) else {
            fatalError()
        }
        let model = viewModel.getQuestionListModel(to: indexPath)
        cell.configure(with: model)
        return cell
    }
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row > 0 {
            let viewControllerName = String(describing: AnswerViewController.self)
            let storyboard = UIStoryboard(name: viewControllerName, bundle: nil)
            guard let answerViewController = storyboard.instantiateViewController(withIdentifier: viewControllerName) as? AnswerViewController else {
                fatalError()
            }
            let questionModel = viewModel.getQuestionListModel(to: indexPath)
            answerViewController.viewModel = AnswerViewModel(questionModel.question, AnswerListUseCase(AnswerRepository()))
            self.navigationController?.pushViewController(answerViewController, animated: true)
        }
    }
}
