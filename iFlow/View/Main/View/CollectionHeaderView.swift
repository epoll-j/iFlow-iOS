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
import DynamicButton
import ProxyService

class CollectionHeaderView: UICollectionReusableView {
    static let identifier = "CollectionHeaderView"
    
    private var cardView: UIView!
    private var animationView: LottieAnimationView!
    private var packetCountView: DataItemView!
    private var timeView: DataItemView!
    private var actionButton: DynamicButton!
    private var proxyService: ProxyService?
    var onHeaderTap: (() -> Void)?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        proxyService = ProxyService.create()
    }
    
    private func setupView() {
        let mainColor = UIColor(red: 110 / 255, green: 125 / 255, blue: 235 / 255, alpha: 0.9)
        
        cardView = UIView().then({ [weak self] in
            guard let self = self else { return }
            addSubview($0)
            $0.snp.makeConstraints { make in
                make.height.equalTo(110)
                make.left.equalToSuperview().offset(25)
                make.right.equalToSuperview().offset(-25)
                make.top.equalToSuperview().offset(65)
            }
            $0.backgroundColor = mainColor
            $0.layer.cornerRadius = 18
            $0.layer.shadowColor = UIColor.black.cgColor
            $0.layer.shadowOpacity = 0.1
            $0.layer.shadowOffset = CGSize(width: 0, height: 1)
            
            self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleHeaderTap(_:))))
        })
        
        _ = UIView().then { [weak self] in
            guard let self = self else { return }
            self.addSubview($0)
            
            $0.snp.makeConstraints { make in
                make.right.equalToSuperview().offset(-25)
                make.height.width.equalTo(50)
                make.top.equalToSuperview()
            }
            
            $0.backgroundColor = mainColor
            $0.layer.cornerRadius = 8
            
            self.actionButton = DynamicButton(style: .play)
            $0.addSubview(self.actionButton)
            self.actionButton.snp.makeConstraints { make in
                make.center.equalToSuperview()
                make.size.equalToSuperview().multipliedBy(0.7)
            }
            self.actionButton.strokeColor = .white
            self.actionButton.addTarget(self, action: #selector(handleAction), for: .touchUpInside)
        }
        
        _ = UIView().then({ [weak self] (view) in
            guard let self = self else { return }
            self.addSubview(view)
            
            view.snp.makeConstraints { make in
                make.left.equalToSuperview().offset(25)
                make.height.equalTo(40)
                make.top.equalToSuperview()
            }
            
            _ = UILabel().then { label in
                view.addSubview(label)
                label.snp.makeConstraints { make in
                    make.bottom.left.equalToSuperview()
                }
                label.text = "免费开源网络调试工具"
                label.textColor = .lightGray
                label.font = .systemFont(ofSize: 12)
            }
            
            _ = UILabel().then { label in
                view.addSubview(label)
                label.snp.makeConstraints { make in
                    make.top.left.equalToSuperview()
                }
                label.text = "iFlow"
                label.textColor = mainColor
                label.font = .systemFont(ofSize: 18, weight: .bold)
            }
        })
        
        animationView = LottieAnimationView(name: "aircraft").then({ [weak self] in
            guard let self = self else { return }
            self.cardView.addSubview($0)
            
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
            guard let self = self else { return }
            self.cardView.addSubview($0)
            
            $0.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.left.equalTo(self.animationView.snp.right)
                make.height.equalToSuperview().multipliedBy(0.35)
            }
            
            $0.title.text = "数据包"
            $0.setContentText("199个")
        })
        
        timeView = DataItemView().then({ [weak self] in
            guard let self = self else { return }
            self.cardView.addSubview($0)
            
            $0.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.left.equalTo(self.packetCountView.snp.right).offset(30)
                make.height.equalTo(self.packetCountView.snp.height)
            }
            
            $0.title.text = "持续时间"
            $0.setContentText("100s")
        })
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleHeaderTap(_ sender: UITapGestureRecognizer) {
        onHeaderTap?()
    }
    
    @objc func handleAction() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100), execute: { [weak self] in
            guard let self = self else {
                return
            }
            self.actionButton.setStyle(self.actionButton.style == .play ? .pause : .play, animated: true)
            //            self.proxyService?.run({ <#Result<Int, any Error>#> in
            //                <#code#>
            //            })
        })
        
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
        
        
        let lastCharFont = UIFont.systemFont(ofSize: 10)
        attributedString.addAttribute(.font, value: lastCharFont, range: range)
        
        content.attributedText = attributedString
        content.sizeToFit()
    }
    
    private func setup() {
        title = UILabel().then({ [weak self] in
            guard let self = self else { return }
            self.addSubview($0)
            $0.snp.makeConstraints { make in
                make.top.left.right.equalToSuperview()
            }
            
            $0.textColor = .white
            $0.font = UIFont.systemFont(ofSize: 10)
        })
        
        content = UILabel().then({ [weak self] in
            guard let self = self else { return }
            self.addSubview($0)
            $0.snp.makeConstraints { make in
                make.bottom.left.right.equalToSuperview()
            }
            
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.textColor = .white
            $0.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        })
    }
}
