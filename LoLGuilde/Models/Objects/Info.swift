import Foundation

struct Info: Codable {
    let attack: Int
    let defense: Int
    let magic: Int
    let difficulty: Int

    enum CodingKeys: String, CodingKey {
        case attack = "attack"
        case defense = "defense"
        case magic = "magic"
        case difficulty = "difficulty"
    }
}
