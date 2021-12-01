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
    func loadAPI()
}

class ItemsViewModel: ItemsViewModelProtocol {

    private let disposeBag = DisposeBag()
    private let itemsServices = ItemsServices()
    var items = BehaviorRelay<[Item]>(value: [])
    var searchResults = BehaviorRelay<[Item]>(value: [])

    private func processItems(_ newItems: [Item]) {
        // update API
        DispatchQueue.main.async {
            self.items.accept(newItems)
            self.searchResults.accept(newItems)
        }
        itemsServices.saveItemsToCache(newItems)
    }

    func loadAPI() {
        let listItems = itemsServices.getItems()
        listItems
            .filter { objects in
                return !objects.isEmpty
            }
            .subscribe(onNext: { [weak self] newItem in
                self?.processItems(newItem)
            })
            .disposed(by: disposeBag)
    }

    func search(searchBar: UISearchBar) {
        searchBar.rx.text
            .orEmpty // Make it non-optional
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .distinctUntilChanged() // If they didn't occur, check if the new value is the same as
            .flatMapLatest { [weak self] query -> Observable<[Item]> in
                guard let self = self else { return .just([]) }
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
            .filter { ($0.name).uppercased().contains(query.uppercased()) }
        return Observable.of(listItems)
    }

    func readItemsFromCache() {
        let listItems = itemsServices.getItemsFromCache()
        self.items.accept(listItems)
    }
}
