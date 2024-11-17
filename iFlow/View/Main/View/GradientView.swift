//
//  GradientView.swift
//  iFlow
//
//  Created by Dubhe on 2024/11/17.
//

import UIKit

class GradientView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradientLayer()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupGradientLayer()
    }
    
    private func setupGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        
        // 设置颜色数组，这里用的是蓝色和白色，可根据需求调整
        gradientLayer.colors = [
            UIColor(red: 238/255, green: 243/255, blue: 253/255, alpha: 1).cgColor,
            UIColor(red: 214/255, green: 234/255, blue: 248/255, alpha: 1).cgColor
        ]
        
        // 设置渐变开始和结束位置，用单位坐标（0,1）表示, 可根据效果调整
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1)
        
        // 添加图层
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // 确保 gradientLayer 在布局变化时尺寸适配
        (self.layer.sublayers?.first as? CAGradientLayer)?.frame = self.bounds
    }
}
