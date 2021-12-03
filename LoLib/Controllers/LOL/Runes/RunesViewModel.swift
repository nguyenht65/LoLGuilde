//
//  RunesViewModel.swift
//  LoLGuilde
//
//  Created by Bang on 11/11/2021.
//

import Foundation
import RxSwift
import RxRelay
import Reachability

class RunesViewModel {

    private let disposeBag = DisposeBag()
    let runesServices = RunesServices()
    var runes = BehaviorRelay<[Rune]>(value: [])
    let reachability = try! Reachability()

    private func processRunes(_ newRunes: [Rune]) {
        DispatchQueue.main.async {
            self.runes.accept(newRunes)
        }
        runesServices.saveRunesToCache(newRunes)
    }

    func loadAPI() {
        let listRunes = runesServices.getRunes()
        listRunes
            .filter { objects in
                return !objects.isEmpty
            }
            .subscribe(onNext: { newRunes in
                self.processRunes(newRunes)
            })
            .disposed(by: disposeBag)
    }

    func readRunesFromCache() {
        let listRunes = runesServices.getRunesFromCache()
        self.runes.accept(listRunes)
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
            self?.readRunesFromCache()
        }
    }
}
