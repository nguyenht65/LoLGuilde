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
