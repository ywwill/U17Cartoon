//
//  U17TabBarController.swift
//  U17Cartoon
//
//  Created by YangWei on 2018/9/14.
//  Copyright © 2018年 Apple-YangWei. All rights reserved.
//

import Foundation
import UIKit

class U17TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildViewControllers()
    }
    
    private func addChildViewControllers() {
        setChildViewController(childController: U17TodayViewController(), title: "", imageName: "tab_today")
        setChildViewController(childController: U17FindViewController(), title: "", imageName: "tab_find")
        setChildViewController(childController: U17BookRackViewController(), title: "", imageName: "tab_book")
        setChildViewController(childController: U17MineViewController(), title: "", imageName: "tab_mine")
    }
    
    private func setChildViewController(childController: UIViewController, title: String, imageName: String) {
        childController.title = title
        childController.tabBarItem.image = UIImage(named: imageName)
        childController.tabBarItem.selectedImage = UIImage(named: imageName + "_selected")
        addChildViewController(UINavigationController(rootViewController: childController))
    }
}


