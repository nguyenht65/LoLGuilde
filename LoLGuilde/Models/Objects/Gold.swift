import Foundation

struct Gold : Codable {

    let base : Int
    let purchasable : Bool
    let total : Int
    let sell : Int

    enum CodingKeys: String, CodingKey {
        case base = "base"
        case purchasable = "purchasable"
        case total = "total"
        case sell = "sell"
    }
}
