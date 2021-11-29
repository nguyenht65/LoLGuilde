//
//  SpellsViewModel.swift
//  LoLGuilde
//
//  Created by Bang on 04/11/2021.
//

import UIKit
import RxSwift
import RxRelay
import RxCocoa

protocol SpellsViewModelProtocol {
    func processSpells(_ newSpell: [Spell])
    func loadAPI()
}

class SpellsViewModel: SpellsViewModelProtocol {

    private let disposeBag = DisposeBag()
    private let spellsFileURL = Helper.cachedFileURL("spells.json")
    var spells = BehaviorRelay<[Spell]>(value: [])

    func processSpells(_ newSpells: [Spell]) {
        // update API
        DispatchQueue.main.async {
            self.spells.accept(newSpells)
        }
        // save data to file
        let encoder = JSONEncoder()
        if let spellsData = try? encoder.encode(newSpells) {
            try? spellsData.write(to: spellsFileURL, options: .atomicWrite)
        }
    }

    func loadAPI() {
        let newSpells = SpellsServices.shared().getSpells()
        newSpells
//            .filter { objects in
//                return !objects.isEmpty
//            }
            .subscribe(onNext: { [weak self] newSpell in
                self?.processSpells(newSpell)
            })
            .disposed(by: disposeBag)
    }

    func readSpellsCache() {
        let decoder = JSONDecoder()
        if let spellData = try? Data(contentsOf: spellsFileURL),
           let preSpells = try? decoder.decode([Spell].self, from: spellData) {
            self.spells.accept(preSpells)
        }
    }
}
