//
//  TabBarItem.swift
//  LoLGuilde
//
//  Created by Bang on 01/11/2021.
//

import UIKit

struct TabBarItem {

    lazy var championsViewController: UIViewController = {
        let navigationController = BaseNavigationController(rootViewController: ChampionsViewController(championsViewModel: ChampionsViewModel()))
        return navigationController
    }()

    lazy var itemsViewController: UIViewController = {
        return ItemsViewController(itemsViewModel: ItemsViewModel())
    }()

    lazy var runesViewController: UIViewController = {
        return RunesViewController(runesViewModel: RunesViewModel())
    }()

    lazy var spellsViewController: UIViewController = {
        return SpellsViewController(spellsViewModel: SpellsViewModel())
    }()

}

enum TabItem: String, CaseIterable {

    case champions = "champions"
    case items = "items"
    case runes = "runes"
    case spells = "spells"

    var viewController: UIViewController {
        var tabBarItem = TabBarItem()
        switch self {
        case .champions:
            return tabBarItem.championsViewController
        case .items:
            return tabBarItem.itemsViewController
        case .runes:
            return tabBarItem.runesViewController
        case .spells:
            return tabBarItem.spellsViewController
        }
    }

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
