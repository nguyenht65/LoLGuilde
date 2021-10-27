//
//  LOLTabBarController.swift
//  LoLGuilde
//
//  Created by Bang on 27/10/2021.
//

import Foundation
import UIKit

class LOLTabBarController: BaseTabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupTabBar() {
        let championsVC = LOLChampionsViewController()
        let itemsVC = LOLItemsViewController()
        let runesVC = LOLRunesViewController()
        championsVC.tabBarItem = UITabBarItem(title: "Champions", image: nil, tag: 0)
        itemsVC.tabBarItem = UITabBarItem(title: "Items", image: nil, tag: 1)
        runesVC.tabBarItem = UITabBarItem(title: "Runes", image: nil, tag: 2)
        self.viewControllers = [championsVC, itemsVC, runesVC]
    }
}
