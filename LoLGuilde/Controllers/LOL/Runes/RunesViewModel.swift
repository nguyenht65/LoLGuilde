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
    private let runesFileURL = Helper.cachedFileURL("runes.json")
    let runesServices = RunesServices()
    var runes = BehaviorRelay<[Rune]>(value: [])

    private func processRunes(_ newRunes: [Rune]) {
        // update API
        DispatchQueue.main.async {
            self.runes.accept(newRunes)
        }
        // save data to file
        let encoder = JSONEncoder()
        if let runesData = try? encoder.encode(newRunes) {
            try? runesData.write(to: runesFileURL, options: .atomicWrite)
        }
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

    func readRunesCache() {
        let decoder = JSONDecoder()
        if let runesData = try? Data(contentsOf: runesFileURL),
           let preRunes = try? decoder.decode([Rune].self, from: runesData) {
            self.runes.accept(preRunes)
        }
    }
    
}
