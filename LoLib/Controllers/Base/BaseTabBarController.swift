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

    lazy var championsViewController: UIViewController = {
        let rootViewController = ChampionsViewController(championsServices: ChampionsServices())
        let navigationController = BaseNavigationController(rootViewController: rootViewController)
        return navigationController
    }()

    lazy var itemsViewController: UIViewController = {
        return ItemsViewController(itemsServices: ItemsServices())
    }()

    lazy var runesViewController: UIViewController = {
        return RunesViewController(runesServices: RunesServices())
    }()

    lazy var spellsViewController: UIViewController = {
        return SpellsViewController(spellsServices: SpellsServices())
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadTabBar()
    }

    func loadTabBar() {
        // create and load custom tab bar
        let tabbarItems: [TabItem] = [.champions, .items, .runes, .spells]
        setupCustomTabMenu(tabbarItems, completion: { viewControllers in
            self.viewControllers = viewControllers
        })
        selectedIndex = 0 // Set default selected index is first index
    }

    func getViewController(item: TabItem) -> UIViewController {
        switch item {
        case .champions:
            return championsViewController
        case .items:
            return itemsViewController
        case .runes:
            return runesViewController
        case .spells:
            return spellsViewController
        }
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
            let controller = getViewController(item: $0)
            controllers.append(controller)
        })

        view.layoutIfNeeded()
        completion(controllers)
    }

    func changeTab(tab: Int) {
        self.selectedIndex = tab
    }
}

enum TabItem: String, CaseIterable {

    case champions = "champions"
    case items = "items"
    case runes = "runes"
    case spells = "spells"

    var icon: UIImage {
        switch self {
        case .champions:
            return UIImage(named: Image.TopicImage.champion.rawValue)!
        case .items:
            return UIImage(named: Image.TopicImage.item.rawValue)!
        case .runes:
            return UIImage(named: Image.TopicImage.rune.rawValue)!
        case .spells:
            return UIImage(named: Image.TopicImage.spell.rawValue)!
        }
    }

    var displayTitle: String {
        return self.rawValue.capitalized(with: nil)
    }
}
