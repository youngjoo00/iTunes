//
//  TabBarController.swift
//  ReadingHaracoon
//
//  Created by youngjoo on 3/7/24.
//

import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstTab = UINavigationController(rootViewController: SearchViewController())
        let firstTabBarItem = UITabBarItem(title: "검색", image: UIImage(systemName: "magnifyingglass"), tag: 3)
        firstTab.tabBarItem = firstTabBarItem

        let secondTab = UINavigationController(rootViewController: StorageViewController())
        let secondTabBarItem = UITabBarItem(title: "보관함", image: UIImage(systemName: "square.stack.fill"), tag: 2)
        secondTab.tabBarItem = secondTabBarItem
        
        self.viewControllers = [firstTab, secondTab]
    }
}
