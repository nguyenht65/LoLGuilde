import Foundation

struct Passive: Codable {
    let name: String
    let description: String
    let image: Image

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case description = "description"
        case image = "image"
    }
}

extension Passive {
    var urlImage: String {
        return Image.EndPoint.passive.urlString + image.full
    }

    var placeholderImage: String {
        return Image.LoadingImage.square.rawValue
    }
}
