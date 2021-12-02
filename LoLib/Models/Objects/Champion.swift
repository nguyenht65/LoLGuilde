//
//  Champion.swift
//  LoLGuilde
//
//  Created by Bang on 27/10/2021.

import Foundation

// MARK: - ChampionBase
struct BaseChampion: Codable {
    let data: [String: Champion]
}

// MARK: - Champion
struct Champion: Codable {
    let id, name, title: String
    let image: Image
    let skins: [Skin]
    let lore, blurb: String
    let allytips, enemytips: [String]
    let tags: [Tag]
    let partype: String
    let info: Info
    let stats: Stats
    let spells: [Spell]
    let passive: Passive

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case title = "title"
        case image = "image"
        case skins = "skins"
        case lore = "lore"
        case blurb = "blurb"
        case allytips = "allytips"
        case enemytips = "enemytips"
        case tags = "tags"
        case partype = "partype"
        case info = "info"
        case stats = "stats"
        case spells = "spells"
        case passive = "passive"
    }
}

enum Tag: String, Codable {
    case assassin = "Assassin"
    case fighter = "Fighter"
    case mage = "Mage"
    case marksman = "Marksman"
    case support = "Support"
    case tank = "Tank"
}

extension Champion {
    var urlImage: String {
        return Image.EndPoint.champion.urlString + image.full
    }

    var placeholderImage: String {
        return Image.LoadingImage.square.rawValue
    }
}

extension Champion {
//    func getStatus(championStatusValue: ChampionStatusValue) -> String {
//        switch championStatusValue {
//        case .health:
//            return "\(stats.hp)(\(stats.hpperlevel))"
//        case .healthRegen:
//            statusValueLabel.text?.append(contentsOf: "\(item.stats.hpregen)(\(item.stats.hpregenperlevel))")
//        case .mana:
//            statusValueLabel.text?.append(contentsOf: "\(item.stats.mp)(\(item.stats.mpperlevel))")
//        case .manaRegen:
//            statusValueLabel.text?.append(contentsOf: "\(item.stats.mpregen)(\(item.stats.mpregenperlevel))")
//        case .attackDamage:
//            statusValueLabel.text?.append(contentsOf: "\(item.stats.attackdamage)(\(item.stats.attackdamageperlevel))")
//        case .attackSpeed:
//            statusValueLabel.text?.append(contentsOf: "\(item.stats.attackspeed)(\(item.stats.attackspeedperlevel))")
//        case .armor:
//            statusValueLabel.text?.append(contentsOf: "\(item.stats.armor)(\(item.stats.armorperlevel))")
//        case .spellBlock:
//            statusValueLabel.text?.append(contentsOf: "\(item.stats.spellblock)(\(item.stats.spellblockperlevel))")
//        case .attackRange:
//            statusValueLabel.text?.append(contentsOf: "\(item.stats.attackrange)")
//        case .moveSpeed:
//            statusValueLabel.text?.append(contentsOf: "\(item.stats.movespeed )")
//        }
//    }
}
