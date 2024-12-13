//
//  LogViewController.swift
//  iFlow
//
//  Created by dubhe on 2024/12/11.
//

import UIKit
import Then
import SnapKit

class LogViewController: UIViewController {
    
    var tableView: UITableView!
    var logs: [LogEntry] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 初始化 TableView
        tableView = UITableView(frame: view.bounds, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(LogTableViewCell.self, forCellReuseIdentifier: LogTableViewCell.identifier)
        self.view.addSubview(tableView)
        
        // 使用 SnapKit 进行 TableView 布局
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // 模拟数据
        loadData()
    }
    
    func loadData() {
        logs = [
            LogEntry(id: 1, method: "POST", url: "https://duga.zhihu.com/api/v2/cores/begin_end", status: 200, type: "HTTP", size: "1.40K / 0.35K", time: "16:15:15", duration: "1.06s"),
            LogEntry(id: 1, method: "POST", url: "https://duga.zhihu.com/api/v2/cores/begin_end_begin_end_begin_end_begin_end", status: 200, type: "HTTP", size: "1.40K / 0.35K", time: "16:15:15", duration: "1.06s")
        ]
    }
    
}


extension LogViewController: UITableViewDataSource, UITableViewDelegate {
    // UITableViewDataSource 方法
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return logs.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "di \(section) lie"
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 16
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LogTableViewCell.identifier, for: indexPath) as! LogTableViewCell
        let logEntry = logs[indexPath.row]
        cell.configure(with: logEntry)
        return cell
    }
    
    // UITableViewDelegate 方法（可选）
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 在这里处理选择操作
    }
}
