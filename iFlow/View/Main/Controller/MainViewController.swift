//
//  MainViewController.swift
//  iFlow
//
//  Created by Dubhe on 2024/11/17.
//

import UIKit
import SnapKit
import Then
import DynamicButton

class MainViewController: UIViewController {
    
    var collectionView: UICollectionView!
    var backgroundView: GradientView!
    let reuseIdentifier = "BoxCell"
    var floatingButton: UIButton!
    
    let boxes = [
        Box(title: "PASSWORDS", items: 28, iconName: "lock"),
        Box(title: "IMAGES", items: 500, iconName: "photo"),
        Box(title: "VIDEOS", items: 13, iconName: "film"),
        Box(title: "RANDOM", items: 9, iconName: "tray"),
        Box(title: "IMPORTANT", items: 6, iconName: "star"),
        Box(title: "UNTITLED", items: 0, iconName: "square")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundView = GradientView()
            .then({ [weak self] in
                self?.view.addSubview($0)
                $0.snp.makeConstraints { make in
                    make.size.equalToSuperview()
                    make.center.equalToSuperview()
                }
            })
        
        let layout = UICollectionViewFlowLayout()
        layout.headerReferenceSize = CGSize(width: view.frame.width, height: 100)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 30, bottom: 200, right: 30)
        layout.itemSize = CGSize(width: (view.frame.size.width - 90) / 2, height: 150)
        layout.minimumLineSpacing = 20
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            .then({ [weak self] in
                self?.view.addSubview($0)
                $0.delegate = self
                $0.dataSource = self
                $0.register(BoxCell.self, forCellWithReuseIdentifier: BoxCell.identifier)
                $0.register(CollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionHeaderView.identifier)
                $0.backgroundColor = .clear
                
                $0.snp.makeConstraints { make in
                    make.left.bottom.right.equalToSuperview()
                    make.height.equalToSuperview()
                }
            })
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return boxes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! BoxCell
        let box = boxes[indexPath.item]
        cell.configure(with: box)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CollectionHeaderView.identifier, for: indexPath)
            return headerView
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Action on cell tap
    }
}
