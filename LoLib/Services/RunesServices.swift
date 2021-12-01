//
//  RunesServices.swift
//  LoLGuilde
//
//  Created by Bang on 24/11/2021.
//

import RxSwift

struct RunesServices {

    private let runesFileURL = Helper.cachedFileURL("runes.json")

    func getRunes() -> Observable<[Rune]> {
        let url = Networking.EndPoint.rune.url
        let request: Observable<BaseRune> = Networking.shared().request(url: url)
        return request
            .map { elements in
                var listRunes: [Rune] = []
                for rune in elements {
                    listRunes.append(rune)
                }
                return listRunes
            }
            .catchAndReturn([])
            .share(replay: 1, scope: .forever)
    }

    func saveRunesToCache(_ newRunes: [Rune]) {
        let encoder = JSONEncoder()
        if let runesData = try? encoder.encode(newRunes) {
            try? runesData.write(to: runesFileURL, options: .atomicWrite)
        }
    }

    func getRunesFromCache() -> [Rune] {
        let decoder = JSONDecoder()
        if let runesData = try? Data(contentsOf: runesFileURL),
           let preRunes = try? decoder.decode([Rune].self, from: runesData) {
            return preRunes
        } else {
            return []
        }
    }
}
