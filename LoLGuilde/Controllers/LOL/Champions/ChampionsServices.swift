//
//  ChampionsServices.swift
//  LoLGuilde
//
//  Created by Bang on 24/11/2021.
//

import RxSwift

struct ChampionsServices {

    private static var sharedChampionsServices: ChampionsServices = {
        let championsServices = ChampionsServices()
        return championsServices
    }()

    static func shared() -> ChampionsServices {
        return sharedChampionsServices
    }

    func getChampions() -> Observable<[Champion]> {
        let url = Networking.EndPoint.champion.url
        let request: Observable<BaseChampion> = Networking.shared().request(url: url)
        return request
            .map { element in
                var listChampions = [Champion]()
                for (_, value) in element.data {
                    listChampions.append(value)
                }
                return listChampions.sorted(by: { $0.name < $1.name })
            }
            .catchAndReturn([])
            .share(replay: 1, scope: .forever)
    }
}
