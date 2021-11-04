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

protocol SpellsProtocol {
    func processSpells(_ newSpell: [Spell])
    func loadAPI()
}

class SpellsViewModel: SpellsProtocol {

    private let urlSpell = "https://nguyenht65.github.io/LOLResources/LoLResouces/lol/data/en_US/summoner.json"
    private let disposeBag = DisposeBag()
    private let spellsFileURL = Helper.cachedFileURL("spells.json")
    var spells = BehaviorRelay<[Spell]>(value: [])
    var spellsView: SpellsViewProtocol?

    func processSpells(_ newSpells: [Spell]) {
        // update API
        DispatchQueue.main.async {
            self.spells.accept(newSpells)
            self.spellsView?.getSpellsSuccess()
        }
        // save data to file
        let encoder = JSONEncoder()
        if let spellsData = try? encoder.encode(newSpells) {
            try? spellsData.write(to: spellsFileURL, options: .atomicWrite)
        }
    }

    func loadAPI() {
        let observable = Observable<String>.of(urlSpell)
            .map { urlString -> URL in
                return URL(string: urlString)!
            }
            .map { url -> URLRequest in
                return URLRequest(url: url)
            }
            .flatMap { request -> Observable<(response: HTTPURLResponse, data: Data)> in
                return URLSession.shared.rx.response(request: request)
            }
            .share(replay: 1)

        observable
            .filter { response, _ -> Bool in
                return 200..<300 ~= response.statusCode
            }
            .map { _, data -> [Spell] in
                var listSpells: [Spell] = []
                let dictionary = Helper.convertToDictionary(data: data)
                if let _listSpells = dictionary?["data"] as? [String: NSDictionary] {
                    for spell in _listSpells {
                        let spellInfor = spell.value
                        if let newSpells = Spell(dictionary: spellInfor) {
                            listSpells.append(newSpells)
                        }
                    }
                }
                return listSpells.sorted(by: { $0.image?.full ?? "" < $1.image?.full ?? "" })
            }
            .filter { objects in
                return !objects.isEmpty
            }
            .subscribe(onNext: { newSpells in
                self.processSpells(newSpells)
            })
            .disposed(by: disposeBag)
    }
    
    func readItemsCache() {
        let decoder = JSONDecoder()
        if let spellData = try? Data(contentsOf: spellsFileURL),
           let preSpells = try? decoder.decode([Spell].self, from: spellData) {
            self.spells.accept(preSpells)
        }
    }
}
