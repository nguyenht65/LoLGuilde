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

protocol ChampionsProtocol {
    func processChampions(_ newChampions: [Champion])
    func loadAPI()
}

class ChampionsViewModel: ChampionsProtocol {
    
    private let urlChampion = "https://nguyenht65.github.io/LOLResources/LoLResouces/lol/data/en_US/championFull.json"
    private let disposeBag = DisposeBag()
    private let championsFileURL = Helper.cachedFileURL("champions.json")
    var champions = BehaviorRelay<[Champion]>(value: [])
    var championView: ChampionsViewProtocol?
    
    func processChampions(_ newChampions: [Champion]) {
        // update API
        DispatchQueue.main.async {
            self.champions.accept(newChampions)
            self.championView?.getChampionsSuccess()
        }
        // save data to file
        let encoder = JSONEncoder()
        if let championsData = try? encoder.encode(newChampions) {
            try? championsData.write(to: championsFileURL, options: .atomicWrite)
        }
    }
    
    func loadAPI() {
        let observable = Observable<String>.of(urlChampion)
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
            .map { _, data -> [Champion] in
                var listChampions: [Champion] = []
                let decoder = JSONDecoder()
                let champion = try? decoder.decode(ChampionBase.self, from: data)
                if let list = champion?.data.values {
                    for i in list {
                        let newChampion = Champion(id: i.id, name: i.name, title: i.title, image: i.image, skins: i.skins, lore: i.lore, blurb: i.blurb, allytips: i.allytips, enemytips: i.enemytips, tags: i.tags, partype: i.partype, info: i.info, stats: i.stats, spells: i.spells, passive: i.passive)
                        listChampions.append(newChampion)
                    }
                }
                print(listChampions.count)
                return listChampions.sorted(by: { $0.name < $1.name })
            }
            .filter { objects in
                return !objects.isEmpty
            }
            .subscribe(onNext: { newChampions in
                self.processChampions(newChampions)
            })
            .disposed(by: disposeBag)
    }

    func readChampionsCache() {
        let decoder = JSONDecoder()
        if let championsData = try? Data(contentsOf: championsFileURL),
           let preChampions = try? decoder.decode([Champion].self, from: championsData) {
            self.champions.accept(preChampions)
        }
    }
    
}
