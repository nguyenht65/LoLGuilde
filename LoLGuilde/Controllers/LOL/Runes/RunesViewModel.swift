//
//  RunesViewModel.swift
//  LoLGuilde
//
//  Created by Bang on 11/11/2021.
//

import Foundation
import RxSwift
import RxRelay

protocol RunesProtocol {
    func processRunes(_ newRunes: [Rune])
    func loadAPI()
}

class RunesViewModel: RunesProtocol {
    
    private let urlRunes = "https://nguyenht65.github.io/LOLResources/LoLResouces/lol/data/en_US/runesReforged.json"
    private let disposeBag = DisposeBag()
    private let runesFileURL = Helper.cachedFileURL("runes.json")
    var runes = BehaviorRelay<[Rune]>(value: [])
    var runesView: RunesViewProtocol?

    func processRunes(_ newRunes: [Rune]) {
        // update API
        DispatchQueue.main.async {
            self.runes.accept(newRunes)
            self.runesView?.getRunesSuccess()
        }
        // save data to file
        let encoder = JSONEncoder()
        if let runesData = try? encoder.encode(newRunes) {
            try? runesData.write(to: runesFileURL, options: .atomicWrite)
        }
    }
    
    func loadAPI() {
        let observable = Observable<String>.of(urlRunes)
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
            .map { _, data -> [Rune] in
                var listRunes: [Rune] = []
                let decoder = JSONDecoder()
                let rune = try? decoder.decode(RuneBase.self, from: data)
                if let list = rune {
                    for i in list {
                        listRunes.append(Rune(rune: i))
                    }
                }
                return listRunes
            }
            .filter { objects in
                return !objects.isEmpty
            }
            .subscribe(onNext: { newRunes in
                self.processRunes(newRunes)
            })
            .disposed(by: disposeBag)
        
    }

    func readRunesCache() {
        let decoder = JSONDecoder()
        if let runesData = try? Data(contentsOf: runesFileURL),
           let preRunes = try? decoder.decode([Rune].self, from: runesData) {
            self.runes.accept(preRunes)
        }
    }
    
}
