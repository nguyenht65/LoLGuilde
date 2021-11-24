// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let runeBase = try? newJSONDecoder().decode(RuneBase.self, from: jsonData)

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
