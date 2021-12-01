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
    func loadAPI()
}

class SpellsViewModel: SpellsViewModelProtocol {

    private let disposeBag = DisposeBag()
    private let spellsServices = SpellsServices()
    var spells = BehaviorRelay<[Spell]>(value: [])

    private func processSpells(_ newSpells: [Spell]) {
        // update API
        DispatchQueue.main.async {
            self.spells.accept(newSpells)
        }
        spellsServices.saveSpellsToCache(newSpells)
    }

    func loadAPI() {
        let listSpells = spellsServices.getSpells()
        listSpells
            .filter { objects in
                return !objects.isEmpty
            }
            .subscribe(onNext: { [weak self] newSpell in
                self?.processSpells(newSpell)
            })
            .disposed(by: disposeBag)
    }

    func readSpellsFromCache() {
        let listSpells = spellsServices.getSpellsFromCache()
        self.spells.accept(listSpells)
    }
}
