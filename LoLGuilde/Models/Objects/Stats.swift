
import Foundation

struct Stats : Codable {
    let hp : Double
    let hpperlevel : Double
    let mp : Double
    let mpperlevel : Double
    let movespeed : Double
    let armor : Double
    let armorperlevel : Double
    let spellblock : Double
    let spellblockperlevel : Double
    let attackrange : Double
    let hpregen : Double
    let hpregenperlevel : Double
    let mpregen : Double
    let mpregenperlevel : Double
    let crit : Double
    let critperlevel : Double
    let attackdamage : Double
    let attackdamageperlevel : Double
    let attackspeedperlevel : Double
    let attackspeed : Double

    enum CodingKeys: String, CodingKey {

        case hp = "hp"
        case hpperlevel = "hpperlevel"
        case mp = "mp"
        case mpperlevel = "mpperlevel"
        case movespeed = "movespeed"
        case armor = "armor"
        case armorperlevel = "armorperlevel"
        case spellblock = "spellblock"
        case spellblockperlevel = "spellblockperlevel"
        case attackrange = "attackrange"
        case hpregen = "hpregen"
        case hpregenperlevel = "hpregenperlevel"
        case mpregen = "mpregen"
        case mpregenperlevel = "mpregenperlevel"
        case crit = "crit"
        case critperlevel = "critperlevel"
        case attackdamage = "attackdamage"
        case attackdamageperlevel = "attackdamageperlevel"
        case attackspeedperlevel = "attackspeedperlevel"
        case attackspeed = "attackspeed"
    }

}
