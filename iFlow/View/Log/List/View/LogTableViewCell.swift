//
//  LogTableViewCell.swift
//  iFlow
//
//  Created by dubhe on 2024/12/11.
//

import UIKit
import SnapKit

struct LogEntry {
    let id: Int
    let method: String
    let url: String
    let status: Int
    let type: String
    let size: String
    let time: String
    let duration: String
}


class LogTableViewCell: UITableViewCell {
    
    static let identifier = "LogTableViewCell"
    
    let methodLabel = UILabel()
    let typeImageView = UIImageView()
    let detailLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        methodLabel.font = UIFont.boldSystemFont(ofSize: 14)
        typeImageView.backgroundColor = .red
        detailLabel.font = UIFont.systemFont(ofSize: 12)

        // 添加标签到内容视图
        contentView.addSubview(methodLabel)
        contentView.addSubview(typeImageView)
        contentView.addSubview(detailLabel)

        typeImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.size.equalTo(30)
        }
        
        
        // 使用 SnapKit 进行布局
        methodLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(10)
            make.leading.equalTo(typeImageView.snp.trailing).offset(10)
            make.trailing.equalTo(contentView).offset(-10)
        }

        detailLabel.snp.makeConstraints { make in
            make.top.equalTo(methodLabel.snp.bottom).offset(5)
            make.leading.equalTo(methodLabel)
            make.trailing.equalTo(methodLabel)
            make.bottom.equalTo(contentView).offset(-10)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with logEntry: LogEntry) {
        methodLabel.text = "\(logEntry.method) \(logEntry.url)"
        detailLabel.text = "#1 [\(logEntry.status)] \(logEntry.type) \(logEntry.time) | \(logEntry.size) | \(logEntry.duration)"
    }
}

