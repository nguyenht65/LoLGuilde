//
//  RunesViewModel.swift
//  LoLGuilde
//
//  Created by Bang on 11/11/2021.
//

import Foundation
import RxSwift
import RxRelay

protocol RunesViewModelProtocol {
    func loadAPI()
}

class RunesViewModel: RunesViewModelProtocol {

    private let disposeBag = DisposeBag()
    let runesServices = RunesServices()
    var runes = BehaviorRelay<[Rune]>(value: [])
    
    private func processRunes(_ newRunes: [Rune]) {
        // update API
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
}
