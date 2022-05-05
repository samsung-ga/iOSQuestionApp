//
//  SettingViewController.swift
//  iOSQuestionApp
//
//  Created by Woody on 2022/05/05.
//

import UIKit

class SettingViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: SettingViewModel!
    
    override func setupAttribute() {
        super.setupAttribute()
        self.navigationItem.title = "설정"
    }
}

extension SettingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(SettingTableViewCell.self,
                                                       for: indexPath) else {
            fatalError()
        }
        let model = viewModel.settingTitleString(at: indexPath)
        cell.configure(item: model)
        return cell
    }
}

extension SettingViewController: UITableViewDelegate {
    
}
