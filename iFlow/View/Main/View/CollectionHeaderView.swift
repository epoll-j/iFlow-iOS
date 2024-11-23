//
//  CollectionHeaderView.swift
//  iFlow
//
//  Created by Dubhe on 2024/11/17.
//

import UIKit
import Then
import SnapKit
import Lottie

class CollectionHeaderView: UICollectionReusableView {
    static let identifier = "CollectionHeaderView"
    
    private var cardView: UIView!
    private var animationView: LottieAnimationView!
    private var packetCountView: DataItemView!
    private var timeView: DataItemView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    private func setupView() {
        cardView = UIView().then({ [weak self] in
            self?.addSubview($0)
            $0.snp.makeConstraints { make in
                make.height.equalTo(110)
                make.left.equalToSuperview().offset(25)
                make.right.equalToSuperview().offset(-25)
            }
            $0.backgroundColor = UIColor(red: 110 / 255, green: 125 / 255, blue: 235 / 255, alpha: 0.9)
            $0.layer.cornerRadius = 18
            $0.layer.shadowColor = UIColor.black.cgColor
            $0.layer.shadowOpacity = 0.1
            $0.layer.shadowOffset = CGSize(width: 0, height: 1)
        })
        
        animationView = LottieAnimationView(name: "aircraft").then({ [weak self] in
            self?.cardView.addSubview($0)
            
            $0.snp.makeConstraints { make in
                make.height.width.equalTo(200)
                make.centerY.equalToSuperview()
                make.left.equalToSuperview().offset(-30)
            }
            
            $0.loopMode = .loop
            $0.animationSpeed = 1.0
            $0.play()
        })
        
        packetCountView = DataItemView().then({ [weak self] in
            self?.cardView.addSubview($0)
            
            $0.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.left.equalTo(self!.animationView.snp.right)
                make.height.equalToSuperview().multipliedBy(0.35)
            }
            
            $0.title.text = "数据包"
            $0.setContentText("199个")
        })
        
        timeView = DataItemView().then({ [weak self] in
            self?.cardView.addSubview($0)
            
            $0.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.left.equalTo(self!.packetCountView.snp.right).offset(30)
                make.height.equalTo(self!.packetCountView.snp.height)
            }
            
            $0.title.text = "持续时间"
            $0.setContentText("100s")
        })
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private class DataItemView: UIView {
    var title: UILabel!
    var content: UILabel!
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setContentText(_ fullText: String) {
    
        let attributedString = NSMutableAttributedString(string: fullText)
        
        let range = NSRange(location: fullText.count - 1, length: 1)
        

        let lastCharFont = UIFont.systemFont(ofSize: 12)
        attributedString.addAttribute(.font, value: lastCharFont, range: range)
        
        content.attributedText = attributedString
        content.sizeToFit()
    }
    
    private func setup() {
        title = UILabel().then({ [weak self] in
            self?.addSubview($0)
            $0.snp.makeConstraints { make in
                make.top.left.right.equalToSuperview()
            }
            
            $0.textColor = .white
            $0.font = UIFont.systemFont(ofSize: 10)
        })
        
        content = UILabel().then({ [weak self] in
            self?.addSubview($0)
            $0.snp.makeConstraints { make in
                make.bottom.left.right.equalToSuperview()
            }
            
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.textColor = .white
            $0.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        })
    }
}
