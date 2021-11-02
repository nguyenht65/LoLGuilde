//
//  Champion.swift
//  LoLGuilde
//
//  Created by Bang on 27/10/2021.
//

import Foundation

public class Champion: Codable {
    public var version : String?
    public var id : String?
    public var key : String?
    public var name : String?
    public var title : String?
    public var blurb : String?
    public var info : Info?
    public var image : Image?
    public var tags : Array<String>?
    public var partype : String?
    public var stats : Stats?
    
    
    required public init?(dictionary: NSDictionary) {
        version = dictionary["version"] as? String
        id = dictionary["id"] as? String
        key = dictionary["key"] as? String
        name = dictionary["name"] as? String
        title = dictionary["title"] as? String
        blurb = dictionary["blurb"] as? String
        if (dictionary["info"] != nil) { info = Info(dictionary: dictionary["info"] as! NSDictionary) }
        if (dictionary["image"] != nil) { image = Image(dictionary: dictionary["image"] as! NSDictionary) }
        if (dictionary["tags"] != nil) { tags = dictionary["tags"] as? [String] }
        partype = dictionary["partype"] as? String
        if (dictionary["stats"] != nil) { stats = Stats(dictionary: dictionary["stats"] as! NSDictionary) }
    }
    
    public func dictionaryRepresentation() -> NSDictionary {
        let dictionary = NSMutableDictionary()
        dictionary.setValue(self.version, forKey: "version")
        dictionary.setValue(self.id, forKey: "id")
        dictionary.setValue(self.key, forKey: "key")
        dictionary.setValue(self.name, forKey: "name")
        dictionary.setValue(self.title, forKey: "title")
        dictionary.setValue(self.blurb, forKey: "blurb")
        dictionary.setValue(self.info?.dictionaryRepresentation(), forKey: "info")
        dictionary.setValue(self.image?.dictionaryRepresentation(), forKey: "image")
        dictionary.setValue(self.partype, forKey: "partype")
        dictionary.setValue(self.stats?.dictionaryRepresentation(), forKey: "stats")

        return dictionary
    }
}



