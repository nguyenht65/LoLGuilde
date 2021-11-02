//
//  Item.swift
//  LoLGuilde
//
//  Created by Bang on 01/11/2021.
//

import Foundation

public class Item: Codable {
    public var name : String?
    public var description : String?
    public var colloq : String?
    public var plaintext : String?
    public var into : Array<String>?
    public var from : Array<String>?
    public var inStore : Bool?
    public var image : Image?
    public var gold : Gold?
    public var tags : Array<String>?
    public var stats : Stats?
    public var depth : Int?


/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let 1001 = 1001(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: 1001 Instance.
*/
    required public init?(dictionary: NSDictionary) {

        name = dictionary["name"] as? String
        description = dictionary["description"] as? String
        colloq = dictionary["colloq"] as? String
        plaintext = dictionary["plaintext"] as? String
        inStore = dictionary["inStore"] as? Bool
        if (dictionary["into"] != nil) { into = dictionary["into"] as? [String] }
        if (dictionary["from"] != nil) { from = dictionary["from"] as? [String] }
        if (dictionary["image"] != nil) { image = Image(dictionary: dictionary["image"] as! NSDictionary) }
        if (dictionary["gold"] != nil) { gold = Gold(dictionary: dictionary["gold"] as! NSDictionary) }
        if (dictionary["tags"] != nil) { tags = dictionary["tags"] as? [String] }
        if (dictionary["stats"] != nil) { stats = Stats(dictionary: dictionary["stats"] as! NSDictionary) }
        depth = dictionary["depth"] as? Int
    }

        
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
    public func dictionaryRepresentation() -> NSDictionary {

        let dictionary = NSMutableDictionary()

        dictionary.setValue(self.name, forKey: "name")
        dictionary.setValue(self.description, forKey: "description")
        dictionary.setValue(self.colloq, forKey: "colloq")
        dictionary.setValue(self.plaintext, forKey: "plaintext")
        dictionary.setValue(self.image?.dictionaryRepresentation(), forKey: "image")
        dictionary.setValue(self.gold?.dictionaryRepresentation(), forKey: "gold")
        dictionary.setValue(self.stats?.dictionaryRepresentation(), forKey: "stats")

        return dictionary
    }

}
