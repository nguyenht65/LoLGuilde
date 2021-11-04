//
//  ItemsViewModel.swift
//  LoLGuilde
//
//  Created by Bang on 02/11/2021.
//

import UIKit
import RxSwift
import RxRelay
import RxCocoa

protocol ItemsProtocol {
    func processItems(_ newItems: [Item])
    func loadAPI()
}

class ItemsViewModel: ItemsProtocol {

    private let urlItem = "https://nguyenht65.github.io/LOLResources/LoLResouces/lol/data/en_US/item.json"
    private let disposeBag = DisposeBag()
    private let itemsFileURL = Helper.cachedFileURL("items.json")
    var items = BehaviorRelay<[Item]>(value: [])
    var itemView: ItemsViewProtocol?

    func processItems(_ newItems: [Item]) {
        // update API
        DispatchQueue.main.async {
            self.items.accept(newItems)
            self.itemView?.getItemsSuccess()
        }
        // save data to file
        let encoder = JSONEncoder()
        if let itemData = try? encoder.encode(newItems) {
            try? itemData.write(to: itemsFileURL, options: .atomicWrite)
        }
    }

    func loadAPI() {
        let observable = Observable<String>.of(urlItem)
            .map { urlString -> URL in
                return URL(string: urlString)!
            }
            .map { url -> URLRequest in
                return URLRequest(url: url)
            }
            .flatMap { request -> Observable<(response: HTTPURLResponse, data: Data)> in
                return URLSession.shared.rx.response(request: request)
            }
            .share(replay: 1)

        observable
            .filter { response, _ -> Bool in
                return 200..<300 ~= response.statusCode
            }
            .map { _, data -> [Item] in
                var listItems: [Item] = []
                let dictionary = Helper.convertToDictionary(data: data)
                if let _listItems = dictionary?["data"] as? [String: NSDictionary] {
                    for item in _listItems {
                        let ItemInfor = item.value
                        if let newItems = Item(dictionary: ItemInfor) {
                            listItems.append(newItems)
                        }
                    }
                }
                return listItems.sorted(by: { $0.image?.full ?? "" < $1.image?.full ?? "" })
            }
            .filter { objects in
                return !objects.isEmpty
            }
            .subscribe(onNext: { newItems in
                self.processItems(newItems)
            })
            .disposed(by: disposeBag)
    }
    
    func readItemsCache() {
        let decoder = JSONDecoder()
        if let itemData = try? Data(contentsOf: itemsFileURL),
           let preItems = try? decoder.decode([Item].self, from: itemData) {
            self.items.accept(preItems)
        }
    }
}
