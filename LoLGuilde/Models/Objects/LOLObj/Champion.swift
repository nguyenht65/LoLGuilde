//
//  Champion.swift
//  LoLGuilde
//
//  Created by Bang on 27/10/2021.
//

import Foundation

class Champion {
    public var version : String?
    public var id : String?
    public var key : String?
    public var name : String?
    public var title : String?
    public var blurb : String?
//    public var info : Info?
    public var image : Image?
    public var partype : String?
//    public var stats : Stats?
//    var image: UIImage
    
    required public init?(dictionary: NSDictionary) {

        version = dictionary["version"] as? String
        id = dictionary["id"] as? String
        key = dictionary["key"] as? String
        name = dictionary["name"] as? String
        title = dictionary["title"] as? String
        blurb = dictionary["blurb"] as? String
//        if (dictionary["info"] != nil) { info = Info(dictionary: dictionary["info"] as! NSDictionary) }
        if (dictionary["image"] != nil) { image = Image(dictionary: dictionary["image"] as! NSDictionary) }
        partype = dictionary["partype"] as? String
//        if (dictionary["stats"] != nil) { stats = Stats(dictionary: dictionary["stats"] as! NSDictionary) }
    }
}



