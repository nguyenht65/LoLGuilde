//
//  ChampionsServices.swift
//  LoLGuilde
//
//  Created by Bang on 24/11/2021.
//

import RxSwift

protocol ChampionsServicesProtocol {
    func getChampions() -> Observable<[Champion]>
    func saveChampionToCache(_ newChampions: [Champion])
    func getChampionsFromCache() -> [Champion]
}

struct ChampionsServices: ChampionsServicesProtocol {

    private let championsFileURL = FileHelper.cachedFileURL("champions.json")

    func getChampions() -> Observable<[Champion]> {
        let url = Networking.EndPoint.champion.url
        let request: Observable<BaseChampion> = Networking.shared().request(url: url)
        return request
            .map { element in
                var listChampions: [Champion] = []
                for (_, value) in element.data {
                    listChampions.append(value)
                }
                return listChampions.sorted(by: { $0.name < $1.name })
            }
            .catchAndReturn([])
            .share(replay: 1, scope: .forever)
    }

    func saveChampionToCache(_ newChampions: [Champion]) {
        // save data to file
        let encoder = JSONEncoder()
        if let championsData = try? encoder.encode(newChampions) {
            try? championsData.write(to: championsFileURL, options: .atomicWrite)
        }
    }

    func getChampionsFromCache() -> [Champion] {
        let decoder = JSONDecoder()
        if let championsData = try? Data(contentsOf: championsFileURL),
           let preChampions = try? decoder.decode([Champion].self, from: championsData) {
            return preChampions
        } else {
            return []
        }
    }
}
