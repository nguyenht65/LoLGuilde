
import Foundation

struct BaseSpell: Codable {
    let data: [String: Spell]
}

struct Spell: Codable {
    let id, name, description, tooltip: String
    let maxrank: Int
    let cooldown: [Double]
    let cooldownBurn: String
    let cost: [Int]
    let costBurn: String
    let costType: String
    let maxammo: String
    let range: [Int]
    let rangeBurn: String
    let image: Image

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case description = "description"
        case tooltip = "tooltip"
        case maxrank = "maxrank"
        case cooldown = "cooldown"
        case cooldownBurn = "cooldownBurn"
        case cost = "cost"
        case costBurn = "costBurn"
        case costType = "costType"
        case maxammo = "maxammo"
        case range = "range"
        case rangeBurn = "rangeBurn"
        case image = "image"
    }
}

extension Spell {
    var urlImage: String {
        return Image.EndPoint.spell.urlString + image.full
    }

    var placeholderImage: String {
        return Image.LoadingImage.square.rawValue
    }
}
