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

protocol ItemsViewModelProtocol {
    func processItems(_ newItems: [Item])
    func loadAPI()
}

class ItemsViewModel: ItemsViewModelProtocol {

    private let disposeBag = DisposeBag()
    private let itemsFileURL = Helper.cachedFileURL("items.json")
    var items = BehaviorRelay<[Item]>(value: [])
    var searchResults = BehaviorRelay<[Item]>(value: [])

    func processItems(_ newItems: [Item]) {
        // update API
        DispatchQueue.main.async {
            self.items.accept(newItems)
            self.searchResults.accept(newItems)
        }
        // save data to file
        let encoder = JSONEncoder()
        if let itemData = try? encoder.encode(newItems) {
            try? itemData.write(to: itemsFileURL, options: .atomicWrite)
        }
    }

    func loadAPI() {
        let newItems = ItemsServices.shared().getItems()
        newItems
//            .filter { objects in
//                return !objects.isEmpty
//            }
            .subscribe(onNext: { [weak self] newItem in
                self?.processItems(newItem)
            })
            .disposed(by: disposeBag)
    }

    func search(searchBar: UISearchBar) {
        searchBar.rx.text.orEmpty
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMapLatest { [weak self] query -> Observable<[Item]> in
                guard let self = self else { return .just([])}
                if query.isEmpty { // case when use not search anythings
                    return self.items.asObservable()
                }
                return self.searchItems(query) // case when use search the query
            }
            .bind(to: searchResults)
            .disposed(by: disposeBag)
    }

    func searchItems(_ query: String) -> Observable<[Item]> {
        let listItems: [Item] = items.value
            .filter{ ($0.name).uppercased().contains(query.uppercased()) }
        return Observable.of(listItems)
    }

    func readItemsCache() {
        let decoder = JSONDecoder()
        if let itemData = try? Data(contentsOf: itemsFileURL),
           let preItems = try? decoder.decode([Item].self, from: itemData) {
            self.items.accept(preItems)
        }
    }
}
