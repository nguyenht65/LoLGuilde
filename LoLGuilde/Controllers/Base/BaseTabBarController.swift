//
//  BaseTabBarController.swift
//  LoLGuilde
//
//  Created by Bang on 20/10/2021.
//

import UIKit

class BaseTabBarController: UITabBarController {

    var customTabBar: CustomTabBar!
    var tabBarHeight: CGFloat = 65.0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadTabBar()
    }

    func loadTabBar() {
        // create and load custom tab bar
        let tabbarItems: [TabItem] = [.champions, .items, .runes, .summoners]
        setupCustomTabMenu(tabbarItems, completion: { viewControllers in
            self.viewControllers = viewControllers
        })
        selectedIndex = 0 // Set default selected index is first index
    }

    func setupCustomTabMenu(_ menuItems: [TabItem], completion: @escaping ([UIViewController]) -> Void) {
        // Handle custom tab bar and event listener
        let frame = tabBar.frame
        var controllers = [UIViewController]()
        tabBar.isHidden = true  // Hide default tab bar of the system
        // create customTabBar
        customTabBar = CustomTabBar(menuItems: menuItems, frame: frame)
        customTabBar.translatesAutoresizingMaskIntoConstraints = false
        customTabBar.clipsToBounds = true
        customTabBar.itemTapped = changeTab(tab:)
        view.addSubview(customTabBar)

        // Auto layout for custom tab bar
        NSLayoutConstraint.activate([
            customTabBar.leadingAnchor.constraint(equalTo: tabBar.leadingAnchor),
            customTabBar.trailingAnchor.constraint(equalTo: tabBar.trailingAnchor),
            customTabBar.widthAnchor.constraint(equalToConstant: tabBar.frame.width),
            customTabBar.heightAnchor.constraint(equalToConstant: tabBarHeight),
            customTabBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        // Add each view controller
        menuItems.forEach({
            controllers.append($0.viewController)
        })

        view.layoutIfNeeded()
        completion(controllers)
    }

    func changeTab(tab: Int) {
        self.selectedIndex = tab
    }
}
