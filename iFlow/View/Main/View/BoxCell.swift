//
//  BoxCell.swift
//  iFlow
//
//  Created by Dubhe on 2024/11/17.
//

import UIKit
import SnapKit
import Then

struct Box {
    let title: String
    let items: Int
    let iconName: String
}

class BoxCell: UICollectionViewCell {
    
    static let identifier = "BoxCell"
    
    let titleLabel = UILabel()
    let descLabel = UILabel()
    let iconImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        backgroundColor = .white
        layer.cornerRadius = 18
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0, height: 1)

        titleLabel.font = .systemFont(ofSize: 14, weight: .bold)
        descLabel.font = .systemFont(ofSize: 12)
        descLabel.textColor = .gray

        addSubview(iconImageView)
        addSubview(titleLabel)
        addSubview(descLabel)
        
        iconImageView.snp.makeConstraints {
            $0.width.height.equalTo(45)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-15)
        }
        
        titleLabel.snp.makeConstraints { [weak self] in
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self!.iconImageView.snp.bottom).offset(10)
        }
        
        descLabel.snp.makeConstraints { [weak self] in
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self!.titleLabel.snp.bottom).offset(5)
        }
    }

    func configure(with box: Box) {
        iconImageView.image = UIImage(systemName: box.iconName)
        titleLabel.text = box.title
        descLabel.text = "\(box.items) Items in Box"
    }
}
