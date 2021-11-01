//
//  Networking.swift
//  LoLGuilde
//  chứa phần tương tác chính và xử lý tương tác API
//
//  Created by Bang on 28/10/2021.
//

import Foundation
import RxSwift

final class Networking {
    
    // MARK: - Endpoint
    enum EndPoint {
        static let baseURL: URL? = URL(string: "https://nguyenht65.github.io/LOLResources/")
        
        case lolChampions
        
        var url: URL? {
            switch self {
            case .lolChampions:
                return EndPoint.baseURL?.appendingPathComponent("LoLResouces/lol/data/en_US/champion.json")
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
    
    // MARK: - Properties
    
    // MARK: - Process methods
    static func jsonDecoder(contentIdentifier: String) -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.userInfo[.contentIdentifier] = contentIdentifier
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }
    
    // MARK: Request: xu ly viec ket noi
    func reqiest<T: Codable>(url: URL?, query: [String: Any] = [:], contentIdentifier: String = "") -> Observable<T> {
        do {
            // check URL == nil
            guard let URL = url,
                  var components = URLComponents(url: URL, resolvingAgainstBaseURL: true) else {
                      throw NetworkingError.invalidURL(url?.absoluteString ?? "n/a")
                  }
            
            // add param to String query
            components.queryItems = try query.compactMap { (key,value) in
                guard let v = value as? CustomStringConvertible else {
                    throw NetworkingError.invalidParameter(key, value)
                }
                return URLQueryItem(name: key, value: v.description)
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
    
//    func getChampions(kind: String) -> Observable<[Champion]> {
//        let query: [String: Any] = [kind : "data"]
//        let url = EndPoint.lolChampions.url
//
//    }
    
}
