import Foundation

// MARK: - Rune
struct Rune: Codable {
    let id: Int
    let key, icon, name: String
    let slots: [Slot]

    init(rune: Rune) {
        self = rune
    }
}

// MARK: - Slot
struct Slot: Codable {
    let runes: [RuneElements]
}

// MARK: - Rune
struct RuneElements: Codable {
    let id: Int
    let key, icon, name, shortDesc: String
    let longDesc: String
}

typealias BaseRune = [Rune]

extension Rune {
    var urlImage: String {
        return Image.EndPoint.rune.urlString 
    }

    var placeholderImage: String {
        return Image.LoadingImage.square.rawValue
    }
}
