
import Foundation
import UIKit

struct Image : Codable {
    let full : String
    let sprite : String
    let group : String
    let x : Int
    let y : Int
    let w : Int
    let h : Int
    
    enum EndPoint {
        static let baseURL: String = "https://nguyenht65.github.io/LOLResources/LoLResouces/lol/img/"
        static let baseURL_2: String = "https://nguyenht65.github.io/LOLResources/LoLResouces/img/"
        
        case passive
        case spell
        case rune
        case item
        case champion
        case skin

        var urlString: String {
            switch self {
            case .passive:
                return EndPoint.baseURL + "passive/"
            case .spell:
                return EndPoint.baseURL + "spell/"
            case .rune:
                return EndPoint.baseURL_2
            case .item:
                return EndPoint.baseURL + "item/"
            case .champion:
                return EndPoint.baseURL + "champion/"
            case .skin:
                return EndPoint.baseURL_2 + "champion/splash/"
            }
        }
    }
    
    enum LoadingImage: String {
        case square = "loading_2"
        case rectangle = "loading"
    }
}
