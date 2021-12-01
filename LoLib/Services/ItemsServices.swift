//
//  ItemsServices.swift
//  LoLGuilde
//
//  Created by Bang on 24/11/2021.
//

import Foundation

import RxSwift

struct ItemsServices {

    private let itemsFileURL = FileHelper.cachedFileURL("items.json")

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

    func saveItemsToCache(_ newItems: [Item]) {
        let encoder = JSONEncoder()
        if let itemData = try? encoder.encode(newItems) {
            try? itemData.write(to: itemsFileURL, options: .atomicWrite)
        }
    }

    func getItemsFromCache() -> [Item] {
        let decoder = JSONDecoder()
        if let itemsData = try? Data(contentsOf: itemsFileURL),
           let preItems = try? decoder.decode([Item].self, from: itemsData) {
            return preItems
        } else {
            return []
        }
    }
}
