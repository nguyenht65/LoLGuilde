import Foundation

struct Image: Codable {
    let full: String
    let sprite: String
    let group: String
//    let x: Int
//    let y: Int
//    let w: Int
//    let h: Int

    enum EndPoint {
        static let baseURL: String = "https://nguyenht65.github.io/LOLResources/lol/img/"
        static let baseURL2: String = "https://nguyenht65.github.io/LOLResources/img/"

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
                return EndPoint.baseURL2
            case .item:
                return EndPoint.baseURL + "item/"
            case .champion:
                return EndPoint.baseURL + "champion/"
            case .skin:
                return EndPoint.baseURL2 + "champion/splash/"
            }
        }
    }

    enum LoadingImage: String {
        case square = "loading_2"
        case rectangle = "loading"
    }

    enum TopicImage: String {
        case champion = "champion_icon"
        case item = "item_icon"
        case rune = "rune_icon"
        case spell = "spell_icon"
    }

    enum RuneBackground: String {
        case domination = "domination"
        case precision = "precision"
        case sorcery = "sorcery"
        case resolve = "resolve"
        case inspiration = "inspiration"
    }
}
