//
//  SettingViewController.swift
//  iOSQuestionApp
//
//  Created by Woody on 2022/05/05.
//

import UIKit

class SettingViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var settings: [String] = ["오픈 소스 라이브러리", "질문 출처"]
    
    override func setupAttribute() {
        super.setupAttribute()
        self.navigationItem.title = "설정"
    }
}

extension SettingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(SettingTableViewCell.self,
                                                       for: indexPath) else {
            fatalError()
        }
        cell.configure(item: settings[indexPath.row])
        return cell
    }
}

extension SettingViewController: UITableViewDelegate {
    
}
