//
//  Champion.swift
//  LoLGuilde
//
//  Created by Bang on 27/10/2021.
//

import Foundation
 
/* For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar */

public class Champion: Codable {
    public var id : String?
    public var key : String?
    public var name : String?
    public var title : String?
    public var image : Image?
    public var skins : Array<Skins>?
    public var lore : String?
    public var blurb : String?
    public var allytips : Array<String>?
    public var enemytips : Array<String>?
    public var tags : Array<String>?
    public var partype : String?
    public var info : Info?
    public var stats : Stats?
    public var spells : Array<Spells>?
    public var passive : Passive?
    public var recommended : Array<String>?


    public class func modelsFromDictionaryArray(array:NSArray) -> [Champion]
    {
        var models:[Champion] = []
        for item in array
        {
            models.append(Champion(dictionary: item as! NSDictionary)!)
        }
        return models
    }
/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let aatrox = Aatrox(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: Aatrox Instance.
*/
    required public init?(dictionary: NSDictionary) {

        id = dictionary["id"] as? String
        key = dictionary["key"] as? String
        name = dictionary["name"] as? String
        title = dictionary["title"] as? String
        if (dictionary["image"] != nil) { image = Image(dictionary: dictionary["image"] as! NSDictionary) }
        if (dictionary["skins"] != nil) { skins = Skins.modelsFromDictionaryArray(array: dictionary["skins"] as! NSArray) }
        lore = dictionary["lore"] as? String
        blurb = dictionary["blurb"] as? String
        if (dictionary["allytips"] != nil) { allytips = dictionary["allytips"] as? [String] }
        if (dictionary["enemytips"] != nil) { enemytips = dictionary["enemytips"] as? [String] }
        if (dictionary["tags"] != nil) { tags = dictionary["tags"] as? [String] }
        partype = dictionary["partype"] as? String
        if (dictionary["info"] != nil) { info = Info(dictionary: dictionary["info"] as! NSDictionary) }
        if (dictionary["stats"] != nil) { stats = Stats(dictionary: dictionary["stats"] as! NSDictionary) }
        if (dictionary["spells"] != nil) { spells = Spells.modelsFromDictionaryArray(array: dictionary["spells"] as! NSArray) }
        if (dictionary["passive"] != nil) { passive = Passive(dictionary: dictionary["passive"] as! NSDictionary) }
        if (dictionary["recommended"] != nil) { recommended = dictionary["recommended"] as? [String] }
    }

        
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
    public func dictionaryRepresentation() -> NSDictionary {

        let dictionary = NSMutableDictionary()

        dictionary.setValue(self.id, forKey: "id")
        dictionary.setValue(self.key, forKey: "key")
        dictionary.setValue(self.name, forKey: "name")
        dictionary.setValue(self.title, forKey: "title")
        dictionary.setValue(self.image?.dictionaryRepresentation(), forKey: "image")
        dictionary.setValue(self.lore, forKey: "lore")
        dictionary.setValue(self.blurb, forKey: "blurb")
        dictionary.setValue(self.partype, forKey: "partype")
        dictionary.setValue(self.info?.dictionaryRepresentation(), forKey: "info")
        dictionary.setValue(self.stats?.dictionaryRepresentation(), forKey: "stats")
        dictionary.setValue(self.passive?.dictionaryRepresentation(), forKey: "passive")

        return dictionary
    }

}
