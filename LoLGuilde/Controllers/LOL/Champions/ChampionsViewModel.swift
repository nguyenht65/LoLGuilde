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
    
    private let urlChampion = "https://nguyenht65.github.io/LOLResources/LoLResouces/lol/data/en_US/champion.json"
    private let disposeBag = DisposeBag()
    private let championsFileURL = Helper.cachedFileURL("lolChampions.json")
    var champions = BehaviorRelay<[Champion]>(value: [])
    var view: ChampionsViewProtocol?
    
    func processChampions(_ newChampions: [Champion]) {
        // update API
        DispatchQueue.main.async {
            self.champions.accept(newChampions)
            self.view?.getChampionsSuccess()
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
                let dictionary = Helper.convertToDictionary(data: data)
                if let _listChampions = dictionary?["data"] as? [String: NSDictionary] {
                    for champion in _listChampions {
                        //let championName = champion.key
                        let championInfor = champion.value
                        if let newChampion = Champion(dictionary: championInfor) {
                            listChampions.append(newChampion)
                        }
                    }
                }
                return listChampions.sorted(by: { $0.name ?? "" < $1.name ?? ""})
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
