//
//  FloatTabBarController.swift
//  iFlow
//
//  Created by Dubhe on 2024/11/17.
//

import UIKit

class FloatTabBarController: UITabBarController {
    var viewController1: MainViewController!
    var viewController2: MainViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setValue(FloatTabBar(), forKey: "tabBar")
        viewController1 = MainViewController()
        viewController1.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "star"), selectedImage: UIImage(systemName: "star.fill"))
        
        viewController2 = MainViewController()
        viewController2.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "lock"), selectedImage: UIImage(systemName: "lock.fill"))
        
        self.viewControllers = [
            UINavigationController(rootViewController: viewController1),
            UINavigationController(rootViewController: viewController2)
        ]
        
        self.tabBar.tintColor = UIColor(red: 34 / 255, green: 34 / 255, blue: 34 / 255, alpha: 1.0)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        var frame = self.tabBar.frame
        frame.size.height = 84
        frame.size.width = frame.size.width - 30
        frame.origin.x = 15
        frame.origin.y = self.view.frame.size.height - frame.size.height - 34
        self.tabBar.frame = frame
        self.tabBar.backgroundColor = .white
        self.tabBar.layer.cornerRadius = 24

        // 设置阴影
        self.tabBar.layer.shadowColor = UIColor.black.cgColor
        self.tabBar.layer.shadowOpacity = 0.1
        self.tabBar.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.tabBar.layer.shadowRadius = 4
    }
}
