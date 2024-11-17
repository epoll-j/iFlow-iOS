//
//  FloatTabBar.swift
//  iFlow
//
//  Created by Dubhe on 2024/11/17.
//

import UIKit

class FloatTabBar: UITabBar {
    override func layoutSubviews() {
        super.layoutSubviews()
        let tabBarButtonW: CGFloat = (UIScreen.main.bounds.size.width - 40) / 2
        var tabBarButtonIndex:CGFloat = 0
        for child in self.subviews {
            let childClass: AnyClass? = NSClassFromString("UITabBarButton")
            if child.isKind(of: childClass!) {
                let frame = CGRect(x: tabBarButtonIndex * tabBarButtonW, y: -8, width: tabBarButtonW, height: 84)
                child.frame = frame
                
                tabBarButtonIndex = tabBarButtonIndex + 1
            }
        }
    }
}
