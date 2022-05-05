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
    
    override func setupAttribute() {
        super.setupAttribute()
        
        self.navigationItem.title = "답변 목록"
        
        tableView.backgroundColor = Pallete.main.color
        tableView.registerWithNib(StatisticTableViewCell.self)
        tableView.registerWithNib(QuestionTableViewCell.self)
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return 10
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
        
        return cell
    }
    
    private func questionCell(for indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(QuestionTableViewCell.self,
                                                       for: indexPath) else {
            fatalError()
        }

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
            self.navigationController?.pushViewController(answerViewController, animated: true)
        }
    }
}
