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
