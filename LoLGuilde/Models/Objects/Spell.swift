
import Foundation

struct BaseSpell: Codable {
    let data: [String: Spell]
}

struct Spell: Codable {
    let id, name, description, tooltip: String
    let maxrank: Int
    let cooldown: [Double]
    let cooldownBurn: String
    let cost: [Int]
    let costBurn: String
//    let effect: [[Double]?]
//    let effectBurn: [String?]
    let costType: CostType
    let maxammo: String
    let range: [Int]
    let rangeBurn: String
    let image: Image

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case description = "description"
        case tooltip = "tooltip"
        case maxrank = "maxrank"
        case cooldown = "cooldown"
        case cooldownBurn = "cooldownBurn"
        case cost = "cost"
        case costBurn = "costBurn"
//        case effect = "effect"
//        case effectBurn = "effectBurn"
        case costType = "costType"
        case maxammo = "maxammo"
        case range = "range"
        case rangeBurn = "rangeBurn"
        case image = "image"
    }
}

extension Spell {
    var urlImage: String {
        return Image.EndPoint.spell.urlString + image.full
    }

    var placeholderImage: String {
        return Image.LoadingImage.square.rawValue
    }
}

enum CostType: String, Codable {
    case abilityresourcename = " {{ abilityresourcename }}"
    case abilityresourcenamePerSecond = " {{ abilityresourcename }} per Second"
    case costTypeHealth = "Health"
    case currentHealth = "% Current Health"
    case empty = ""
    case energy = " Energy"
    case furyASecond = " Fury a Second"
    case generates1Ferocity = "Generates 1 Ferocity"
    case health = " Health"
    case heat = " Heat"
    case mana = " Mana"
    case manaAllCharges = " Mana, all Charges"
    case manaPerRocket = " Mana Per Rocket"
    case manaPerSecond = " Mana per Second"
    case manaPercentmanacost100MaxMana = " Mana + {{ percentmanacost*100 }}% Max Mana"
    case manacostpersecondManaPerSecond = " + {{ manacostpersecond }} Mana per second"
    case maxHealthCostMana = "% Max Health, {{ cost }} Mana"
    case noCost = "No Cost"
    case ofCurrentHealth = "% of current Health"
    case ofCurrentHealthHealthcosttooltip = "% of current Health ({{ healthcosttooltip }})"
    case ofCurrentHealthTooltiphealthcost = "% of current Health ({{ tooltiphealthcost }})"
    case ofMaxHealth = "% of max Health"
    case passive = "Passive"
    case the1Seed = "1 Seed"
    case turretKitCostMana = " Turret Kit & {{ cost }} Mana"
    case nbsp = "&nbsp;"
}
