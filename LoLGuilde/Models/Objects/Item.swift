import Foundation

struct BaseItem: Codable {
    let data: [String: Item]
}

struct Item: Codable {
    let name: String
    let description: String
    let plaintext: String
    let into: [String]?
    let from: [String]?
    let image: Image
    let gold: Gold
    let tags: [String]

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case description = "description"
        case plaintext = "plaintext"
        case into = "into"
        case from = "from"
        case image = "image"
        case gold = "gold"
        case tags = "tags"
    }
}

extension Item {
    var urlImage: String {
        return Image.EndPoint.item.urlString + image.full
    }

    var placeholderImage: String {
        return Image.LoadingImage.square.rawValue
    }
}
