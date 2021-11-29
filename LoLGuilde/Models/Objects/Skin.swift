import Foundation

struct Skin: Codable {
    let id: String
    let num: Int
    let name: String
    let chromas: Bool

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case num = "num"
        case name = "name"
        case chromas = "chromas"
    }
}

extension Skin {
    var urlImage: String {
        return Image.EndPoint.skin.urlString
    }

    var imageFormat: String {
        return ".jpg"
    }

    var placeholderImage: String {
        return Image.LoadingImage.rectangle.rawValue
    }
}
