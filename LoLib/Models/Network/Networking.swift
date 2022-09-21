//
//  Networking.swift
//  LoLGuilde
//  chứa phần tương tác chính và xử lý tương tác API
//
//  Created by Bang on 28/10/2021.
//

import Foundation
import RxSwift

final class GameVersion {
    static let version: String = "12.18.1"
}

final class Networking {

    // MARK: - Endpoint
    enum EndPoint {
//        static let baseUrlString = "https://nguyenht65.github.io/LOLResources/lol/data"
        static let baseUrlString = "https://ddragon.leagueoflegends.com/cdn/\(GameVersion.version)/data"
        static let language = "/en_US"

        static var baseURL: URL {
            return URL(string: Networking.EndPoint.baseUrlString + Networking.EndPoint.language)!
        }

        case champion
        case item
        case rune
        case spell

        var url: URL? {
            switch self {
            case .champion:
                return EndPoint.baseURL.appendingPathComponent("/championFull.json")
            case .item:
                return EndPoint.baseURL.appendingPathComponent("/item.json")
            case .rune:
                return EndPoint.baseURL.appendingPathComponent("/runesReforged.json")
            case .spell:
                return EndPoint.baseURL.appendingPathComponent("/summoner.json")
            }
        }
    }

    // MARK: - Singleton -> call API fast
    private static var sharedNetworking: Networking = {
        let networking = Networking()
        return networking
    }()

    class func shared() -> Networking {
        return sharedNetworking
    }

    private init() { }

    // MARK: Request
    func request<T: Codable>(url: URL?) -> Observable<T> {
        do {
            // check URL == nil
            guard let URL = url,
                  let components = URLComponents(url: URL, resolvingAgainstBaseURL: true) else {
                      throw NetworkingError.invalidURL(url?.absoluteString ?? "n/a")
                  }
            // get final url
            guard let finalURL = components.url else {
                throw NetworkingError.invalidURL(url?.absoluteString ?? "n/a")
            }
            let request = URLRequest(url: finalURL)
            // connect with urlRequest
            return URLSession.shared.rx.response(request: request)
                .map { (result: (response: HTTPURLResponse, data: Data)) -> T in
                    let decoder = JSONDecoder()
                    return try! decoder.decode(T.self, from: result.data)
                }
        } catch {
            print(error.localizedDescription)
            return Observable.empty()
        }
    }
}
