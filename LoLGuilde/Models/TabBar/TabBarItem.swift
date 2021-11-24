//
//  TabBarItem.swift
//  LoLGuilde
//
//  Created by Bang on 01/11/2021.
//

import UIKit

enum TabItem: String, CaseIterable {
    case champions = "champions"
    case items = "items"
    case runes = "runes"
    case spells = "spells"

    var viewController: UIViewController {
        switch self {
        case .champions:
            let navigationController = UINavigationController(rootViewController: ChampionsViewController(championsViewModel: ChampionsViewModel()))
            return navigationController
        case .items:
            return ItemsViewController(itemsViewModel: ItemsViewModel())
        case .runes:
            return RunesViewController(runesViewModel: RunesViewModel())
        case .spells:
            return SpellsViewController(spellsViewModel: SpellsViewModel())
        }
    }

    var icon: UIImage {
        switch self {
        case .champions:
            return UIImage(named: Image.TopicImage.ic.rawValue)!
        case .items:
            return UIImage(named: Image.TopicImage.ic.rawValue)!
        case .runes:
            return UIImage(named: Image.TopicImage.ic.rawValue)!
        case .spells:
            return UIImage(named: Image.TopicImage.ic.rawValue)!
        }
    }

    var displayTitle: String {
        return self.rawValue.capitalized(with: nil)
    }
}

