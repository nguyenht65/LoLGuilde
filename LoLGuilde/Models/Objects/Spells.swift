//
//  Spell.swift
//  LoLGuilde
//
//  Created by Bang on 04/11/2021.
//

import Foundation
/* For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar */

public class Spells: Codable {
    public var id : String?
    public var name : String?
    public var description : String?
    public var tooltip : String?
    public var maxrank : Int?
    public var cooldown : Array<Int>?
    public var cooldownBurn : String?
    public var cost : Array<Int>?
    public var costBurn : String?
//    public var datavalues : Datavalues?
    public var effect : Array<String>?
    public var effectBurn : Array<String>?
    public var vars : Array<String>?
    public var key : String?
    public var summonerLevel : Int?
    public var modes : Array<String>?
    public var costType : String?
    public var maxammo : String?
    public var range : Array<Int>?
    public var rangeBurn : String?
    public var image : Image?
    public var resource : String?

/**
    Returns an array of models based on given dictionary.
     
    Sample usage:
    let spells_list = Spells.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of Spells Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [Spells]
    {
        var models:[Spells] = []
        for item in array
        {
            models.append(Spells(dictionary: item as! NSDictionary)!)
        }
        return models
    }
/**
    Constructs the object based on the given dictionary.
     
    Sample usage:
    let summonerBarrier = SummonerBarrier(someDictionaryFromJSON)
     
    - parameter dictionary:  NSDictionary from JSON.
     
    - returns: SummonerBarrier Instance.
*/
    required public init?(dictionary: NSDictionary) {

        id = dictionary["id"] as? String
        name = dictionary["name"] as? String
        description = dictionary["description"] as? String
        tooltip = dictionary["tooltip"] as? String
        maxrank = dictionary["maxrank"] as? Int
        if (dictionary["cooldown"] != nil) { cooldown = dictionary["cooldown"] as? [Int] }
        cooldownBurn = dictionary["cooldownBurn"] as? String
        if (dictionary["cost"] != nil) { cost = dictionary["cost"] as? [Int] }
        costBurn = dictionary["costBurn"] as? String
//        if (dictionary["datavalues"] != nil) { datavalues = Datavalues(dictionary: dictionary["datavalues"] as! NSDictionary) }
        if (dictionary["effect"] != nil) { effect = dictionary["effect"] as? [String] }
        if (dictionary["effectBurn"] != nil) { effectBurn = dictionary["effectBurn"] as? [String] }
        if (dictionary["vars"] != nil) { vars = dictionary["vars"] as? [String] }
        key = dictionary["key"] as? String
        summonerLevel = dictionary["summonerLevel"] as? Int
        if (dictionary["modes"] != nil) { modes = dictionary["modes"] as? [String] }
        costType = dictionary["costType"] as? String
        maxammo = dictionary["maxammo"] as? String
        if (dictionary["range"] != nil) { range = dictionary["range"] as? [Int] }
        rangeBurn = dictionary["rangeBurn"] as? String
        if (dictionary["image"] != nil) { image = Image(dictionary: dictionary["image"] as! NSDictionary) }
        resource = dictionary["resource"] as? String
    }

/**
    Returns the dictionary representation for the current instance.
 
    - returns: NSDictionary.
*/
    public func dictionaryRepresentation() -> NSDictionary {

        let dictionary = NSMutableDictionary()
        dictionary.setValue(self.id, forKey: "id")
        dictionary.setValue(self.name, forKey: "name")
        dictionary.setValue(self.description, forKey: "description")
        dictionary.setValue(self.tooltip, forKey: "tooltip")
        dictionary.setValue(self.maxrank, forKey: "maxrank")
        dictionary.setValue(self.cooldownBurn, forKey: "cooldownBurn")
        dictionary.setValue(self.costBurn, forKey: "costBurn")
//        dictionary.setValue(self.datavalues?.dictionaryRepresentation(), forKey: "datavalues")
        dictionary.setValue(self.key, forKey: "key")
        dictionary.setValue(self.summonerLevel, forKey: "summonerLevel")
        dictionary.setValue(self.costType, forKey: "costType")
        dictionary.setValue(self.maxammo, forKey: "maxammo")
        dictionary.setValue(self.rangeBurn, forKey: "rangeBurn")
        dictionary.setValue(self.image?.dictionaryRepresentation(), forKey: "image")
        dictionary.setValue(self.resource, forKey: "resource")

        return dictionary
    }

}
