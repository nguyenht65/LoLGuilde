//
//  ItemsServices.swift
//  LoLGuilde
//
//  Created by Bang on 24/11/2021.
//

import Foundation

import RxSwift

struct ItemsServices {

    private static var sharedItemsServices: ItemsServices = {
        let itemsServices = ItemsServices()
        return itemsServices
    }()

    static func shared() -> ItemsServices {
        return sharedItemsServices
    }

    func getItems() -> Observable<[Item]> {
        let url = Networking.EndPoint.item.url
        let request: Observable<BaseItem> = Networking.shared().request(url: url)
        return request
            .map { element in
                var listItems: [Item] = []
                for (_, value) in element.data {
                    listItems.append(value)
                }
                return listItems.sorted(by: { $0.image.full < $1.image.full })
            }
            .catchAndReturn([])
            .share(replay: 1, scope: .forever)
    }
}
