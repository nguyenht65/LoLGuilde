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
import Reachability

class ChampionsViewModel {

    private let disposeBag = DisposeBag()
    private let championsServices = ChampionsServices()
    var champions = BehaviorRelay<[Champion]>(value: [])
    var searchResults = BehaviorRelay<[Champion]>(value: [])
    let reachability = try! Reachability()

    private func processChampions(_ newChampions: [Champion]) {
        // update API
        DispatchQueue.main.async {
            self.champions.accept(newChampions)
            self.searchResults.accept(newChampions)
        }
        championsServices.saveChampionToCache(newChampions)
    }

    func loadAPI() {
        let listChampions = championsServices.getChampions()
        listChampions
            .filter { objects in
                return !objects.isEmpty
            }
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
                guard let self = self else { return .just([]) }
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
            .filter { $0.name.uppercased().contains(query.uppercased()) }
        return Observable.of(listChampions)
    }

    func readChampionsFromCache() {
        let listChampions = championsServices.getChampionsFromCache()
        self.champions.accept(listChampions)
    }

    func loadData() {
        do {
            try self.reachability.startNotifier()
        } catch {
            fatalError("Unable to start notifier")
        }
        reachability.whenReachable = { [weak self] reachability in
            let connection = reachability.connection
            if connection == .wifi || connection == .cellular {
                self?.loadAPI()
            }
        }
        reachability.whenUnreachable = { [weak self] _ in
            self?.readChampionsFromCache()
        }
    }
}
