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
        
//        let firstTab = UINavigationController(rootViewController: StorageBookViewController())
//        let firstTabBarItem = UITabBarItem(title: "투데이", image: UIImage(systemName: "book"), tag: 0)
//        firstTab.tabBarItem = firstTabBarItem
//        
//        let secondTab = UINavigationController(rootViewController: SearchViewController())
//        let secondTabBarItem = UITabBarItem(title: "게임", image: UIImage(systemName: "gamecontroller"), tag: 1)
//        secondTab.tabBarItem = secondTabBarItem
//        
//        let thirdTab = UINavigationController(rootViewController: StatsTabViewController())
//        let thirdTabBarItem = UITabBarItem(title: "앱", image: UIImage(systemName: "square.stack.fill"), tag: 2)
//        thirdTab.tabBarItem = thirdTabBarItem
//        
//        let forthTab = UINavigationController(rootViewController: SettingViewController())
//        let forthTabBarItem = UITabBarItem(title: "아케이드", image: UIImage(systemName: "star"), tag: 3)
//        forthTab.tabBarItem = forthTabBarItem
        
        let fiveTab = UINavigationController(rootViewController: SearchViewController())
        let fiveTabBarItem = UITabBarItem(title: "검색", image: UIImage(systemName: "magnifyingglass"), tag: 3)
        fiveTab.tabBarItem = fiveTabBarItem
        
        //self.viewControllers = [firstTab, secondTab, thirdTab, forthTab, fiveTab]
        self.viewControllers = [fiveTab]
    }
}
