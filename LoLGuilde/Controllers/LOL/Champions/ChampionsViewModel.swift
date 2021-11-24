//
//  ChampionsViewModel.swift
//  LoLGuilde
//
//  Created by Bang on 31/10/2021.
//

import UIKit
import RxSwift
import RxRelay
import RxCocoa

protocol ChampionsViewModelProtocol {
    func processChampions(_ newChampions: [Champion])
    func loadAPI()
}

class ChampionsViewModel: ChampionsViewModelProtocol {

    private let disposeBag = DisposeBag()
    private let championsFileURL = Helper.cachedFileURL("champions.json")
    var champions = BehaviorRelay<[Champion]>(value: [])
    var searchResults = BehaviorRelay<[Champion]>(value: [])

    func processChampions(_ newChampions: [Champion]) {
        // update API
        DispatchQueue.main.async {
            self.champions.accept(newChampions)
            self.searchResults.accept(newChampions)
        }
        // save data to file
        let encoder = JSONEncoder()
        if let championsData = try? encoder.encode(newChampions) {
            try? championsData.write(to: championsFileURL, options: .atomicWrite)
        }
    }

    func loadAPI() {
        let newChampions = ChampionsServices.shared().getChampions()
        newChampions
//            .filter { objects in
//                return !objects.isEmpty
//            }
            .subscribe(onNext: { [weak self] newChampion in
                self?.processChampions(newChampion)
            })
            .disposed(by: disposeBag)
    }

    func search(searchBar: UISearchBar) {
        searchBar.rx.text.orEmpty
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMapLatest { [weak self] query -> Observable<[Champion]> in
                guard let self = self else { return .just([])}
                if query.isEmpty { // case when use not search anythings
                    return self.champions.asObservable()
                }
                return self.searchChampions(query) // case when use search the query
            }
            .bind(to: searchResults)
            .disposed(by: disposeBag)
    }

    func searchChampions(_ query: String) -> Observable<[Champion]> {
        let listChampions: [Champion] = champions.value
            .filter { ($0.name).uppercased().contains(query.uppercased()) }
        return Observable.of(listChampions)
    }

    func readChampionsCache() {
        let decoder = JSONDecoder()
        if let championsData = try? Data(contentsOf: championsFileURL),
           let preChampions = try? decoder.decode([Champion].self, from: championsData) {
            self.champions.accept(preChampions)
        }
    }
}
