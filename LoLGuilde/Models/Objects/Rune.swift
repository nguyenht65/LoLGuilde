//
//  Rune.swift
//  LoLGuilde
//
//  Created by Bang on 11/11/2021.
//

import Foundation

public class Rune: Codable {
    public var id : Int?
    public var key : String?
    public var icon : String?
    public var name : String?
    public var slots : Array<Slots>?

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let json4Swift_Base_list = Rune.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of Rune Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [Rune]
    {
        var models:[Rune] = []
        for item in array
        {
            models.append(Rune(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let json4Swift_Base = Rune(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: Rune Instance.
*/
    required public init?(dictionary: NSDictionary) {

        id = dictionary["id"] as? Int
        key = dictionary["key"] as? String
        icon = dictionary["icon"] as? String
        name = dictionary["name"] as? String
        if (dictionary["slots"] != nil) { slots = Slots.modelsFromDictionaryArray(array: dictionary["slots"] as! NSArray) }
    }

/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
    public func dictionaryRepresentation() -> NSDictionary {

        let dictionary = NSMutableDictionary()

        dictionary.setValue(self.id, forKey: "id")
        dictionary.setValue(self.key, forKey: "key")
        dictionary.setValue(self.icon, forKey: "icon")
        dictionary.setValue(self.name, forKey: "name")

        return dictionary
    }

}

