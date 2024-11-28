//
//  HostFilterMainController.swift
//  iFlow
//
//  Created by dubhe on 2024/11/28.
//

import UIKit
import Tabman
import Pageboy

class HostFilterTabViewController: TabmanViewController {
    
    private var viewControllers = [HostFilterViewController(type: .white), HostFilterViewController(type: .black)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.title = "域名过滤"
        dataSource = self
        
        let bar = TMBar.ButtonBar()
        bar.layout.transitionStyle = .snap
        bar.layout.alignment = .centerDistributed
        bar.buttons.customize {
            $0.contentInset = UIEdgeInsets(top: 20.0, left: 20.0, bottom: 0.0, right: 20.0)
        }
        addBar(bar, dataSource: self, at: .top)
        
    }
}

extension HostFilterTabViewController: PageboyViewControllerDataSource, TMBarDataSource {

    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }

    func viewController(for pageboyViewController: PageboyViewController,
                        at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }

    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }

    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        return TMBarItem(title: index == 0 ? "白名单" : "黑名单")
    }
}
