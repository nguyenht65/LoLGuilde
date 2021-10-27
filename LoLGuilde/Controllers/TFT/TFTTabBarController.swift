//
//  TFTTabBarController.swift
//  LoLGuilde
//
//  Created by Bang on 27/10/2021.
//

import Foundation
import UIKit

class TFTTabBarController: BaseTabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupTabBar() {
        let championsVC = TFTChampionsViewController()
        let itemsVC = TFTItemsViewController()
        championsVC.tabBarItem = UITabBarItem(title: "Champions", image: nil, tag: 0)
        itemsVC.tabBarItem = UITabBarItem(title: "Items", image: nil, tag: 1)
        self.viewControllers = [championsVC, itemsVC]
    }
}
