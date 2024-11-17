//
//  CollectionHeaderView.swift
//  iFlow
//
//  Created by Dubhe on 2024/11/17.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {
    static let identifier = "CollectionHeaderView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let label = UILabel()
        label.text = "Header"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
