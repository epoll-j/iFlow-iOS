//
//  HostFilterViewController.swift
//  iFlow
//
//  Created by dubhe on 2024/11/28.
//

import UIKit
import SnapKit
import Database
import Tabman

enum FilterType {
    case white
    case black
}

class HostFilterViewController: UIViewController {
    
    let type: FilterType
    
    private let tableView = UITableView()
    private let enableSwitch = UISwitch()
    private var hosts: [HostFilter] = []
    private let table = HostFilterTable()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(type: FilterType) {
        self.type = type
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        reloadData()
    }
        
    func reloadData() {
        do {
            hosts = try self.table.fetchByType(type == .white ? 0 : 1)
        } catch {
            hosts = []
        }
    }
    
    func setupUI() {
        // 顶部描述视图
        let headerView = UIView()
        view.addSubview(headerView)
        
        headerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(80)
        }
        
        let headerLabel = UILabel()
        headerLabel.text = "\(type == .white ? "白" : "黑")名单列表"
        headerLabel.font = .boldSystemFont(ofSize: 20)
        headerView.addSubview(headerLabel)
        
        headerLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
        }
        
        let headerDescription = UILabel()
        headerDescription.text = type == .white ? "只代理白名单中的域名, 白名单启用黑名单将会失效" : "只忽略黑名单中的域名, 黑名单启用白名单将会失效"
        headerDescription.font = .systemFont(ofSize: 14)
        headerDescription.textColor = .gray
        headerDescription.numberOfLines = 0
        headerView.addSubview(headerDescription)
        
        headerDescription.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom).offset(5)
        }
        
        // "启用" 标签和 Switch
        let enableView = UIView()
        view.addSubview(enableView)
        
        enableView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        
        let enableLabel = UILabel()
        enableLabel.text = "启用"
        enableLabel.font = .systemFont(ofSize: 16)
        enableLabel.textColor = .black
        enableView.addSubview(enableLabel)
        
        enableSwitch.isOn = false
        enableView.addSubview(enableSwitch)
        
        enableLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview()
        }
        
        enableSwitch.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        // 创建阴影容器
        let shadowContainer = UIView()
        shadowContainer.layer.shadowColor = UIColor.black.cgColor
        shadowContainer.layer.shadowOpacity = 0.1
        shadowContainer.layer.shadowOffset = CGSize(width: 0, height: 5)
        shadowContainer.layer.shadowRadius = 10
        view.addSubview(shadowContainer)
        
        // 添加表格视图
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.layer.cornerRadius = 15
        tableView.layer.masksToBounds = true
        shadowContainer.addSubview(tableView)
        
        shadowContainer.snp.makeConstraints { make in
            make.top.equalTo(enableSwitch.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().inset(150)
        }
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // 添加按钮
        let addButton = UIButton(type: .system)
        addButton.setTitle("添加", for: .normal)
        addButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        addButton.setTitleColor(UIColor.systemBlue, for: .normal)
        addButton.backgroundColor = .white
        addButton.layer.cornerRadius = 15
        addButton.layer.shadowColor = UIColor.lightGray.cgColor
        addButton.layer.shadowRadius = 10
        addButton.layer.shadowOpacity = 0.5
        addButton.layer.shadowOffset = CGSize(width: 0, height: 5)
        addButton.addTarget(self, action: #selector(addHost), for: .touchUpInside)
        view.addSubview(addButton)
        
        addButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-50)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
    }
    
    @objc func addHost() {
        let alertController = UIAlertController(title: "添加 Host", message: "请输入新的 Host", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Host"
        }
        let addAction = UIAlertAction(title: "添加", style: .default) { [weak self] _ in
            guard let self = self else { return }
            if let host = alertController.textFields?.first?.text, !host.isEmpty {
                try? self.table.insert(model: HostFilter(id: 0, host: host, type: self.type == .white ? 0 : 1))
                self.reloadData()
                self.tableView.reloadData()
            }
        }
        
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }
    
}


extension HostFilterViewController: UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, UIGestureRecognizerDelegate {
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = hosts.count
        if count == 0 {
            let messageLabel = UILabel()
            messageLabel.text = "暂无记录"
            messageLabel.textAlignment = .center
            messageLabel.font = UIFont.systemFont(ofSize: 16)
            messageLabel.textColor = .gray
            messageLabel.sizeToFit()
            tableView.backgroundView = messageLabel
        } else {
            tableView.backgroundView = nil
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = hosts[indexPath.row].host
        
        return cell
    }
    
    // MARK: - Editing
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            try? table.delete(model: hosts.remove(at: indexPath.row))
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
