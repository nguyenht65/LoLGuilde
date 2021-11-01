//
//  TabBarItem.swift
//  LoLGuilde
//
//  Created by Bang on 01/11/2021.
//

import UIKit

enum TabItem: String, CaseIterable {
    case champions = "champion"
    case items = "item"
    case runes = "rune"
    case summoners = "summoner"

    var viewController: UIViewController {
        switch self {
        case .champions:
            return ChampionsViewController()
        case .items:
            return ItemsViewController()
        case .runes:
            return RunesViewController()
        case .summoners:
            return SummonersViewController()
        }
    }

    var icon: UIImage {
        switch self {
        case .champions:
            return UIImage(named: "ic_tb1")!
        case .items:
            return UIImage(named: "ic_tb2")!
        case .runes:
            return UIImage(named: "ic_tb1")!
        case .summoners:
            return UIImage(named: "ic_tb2")!
        }
    }

    var displayTitle: String {
        return self.rawValue.capitalized(with: nil)
    }
}

