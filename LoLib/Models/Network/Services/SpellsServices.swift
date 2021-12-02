//
//  SpellsServices.swift
//  LoLGuilde
//
//  Created by Bang on 24/11/2021.
//

import RxSwift

protocol SpellsServicesProtocol {
    func getSpells() -> Observable<[Spell]>
    func saveSpellsToCache(_ newSpells: [Spell])
    func getSpellsFromCache() -> [Spell]
}

struct SpellsServices: SpellsServicesProtocol {

    private let spellsFileURL = FileHelper.cachedFileURL("spells.json")

    func getSpells() -> Observable<[Spell]> {
        let url = Networking.EndPoint.spell.url
        let request: Observable<BaseSpell> = Networking.shared().request(url: url)
        return request
            .map { element in
                var listSpells: [Spell] = []
                for (_, value) in element.data {
                    listSpells.append(value)
                }
                return listSpells.sorted(by: { $0.image.full < $1.image.full })
            }
            .catchAndReturn([])
            .share(replay: 1, scope: .forever)
    }

    func saveSpellsToCache(_ newSpells: [Spell]) {
        let encoder = JSONEncoder()
        if let spellsData = try? encoder.encode(newSpells) {
            try? spellsData.write(to: spellsFileURL, options: .atomicWrite)
        }
    }

    func getSpellsFromCache() -> [Spell] {
        let decoder = JSONDecoder()
        if let spellData = try? Data(contentsOf: spellsFileURL),
           let preSpells = try? decoder.decode([Spell].self, from: spellData) {
            return preSpells
        } else {
            return []
        }
    }
}
