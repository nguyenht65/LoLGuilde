//
//  SpellsServices.swift
//  LoLGuilde
//
//  Created by Bang on 24/11/2021.
//

import RxSwift

struct SpellsServices {

    private static var sharedSpellsServices: SpellsServices = {
        let spellsServices = SpellsServices()
        return spellsServices
    }()

    static func shared() -> SpellsServices {
        return sharedSpellsServices
    }

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
}
