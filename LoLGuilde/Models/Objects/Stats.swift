/* 
Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

import Foundation
 
/* For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar */

public class Stats: Codable {
	public var hp : Int?
	public var hpperlevel : Int?
	public var mp : Int?
	public var mpperlevel : Int?
	public var movespeed : Int?
	public var armor : Int?
	public var armorperlevel : Int?
	public var spellblock : Int?
	public var spellblockperlevel : Double?
	public var attackrange : Int?
	public var hpregen : Double?
	public var hpregenperlevel : Double?
	public var mpregen : Int?
	public var mpregenperlevel : Double?
	public var crit : Int?
	public var critperlevel : Int?
	public var attackdamage : Int?
	public var attackdamageperlevel : Double?
	public var attackspeedperlevel : Double?
	public var attackspeed : Double?

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let stats_list = Stats.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of Stats Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [Stats]
    {
        var models:[Stats] = []
        for item in array
        {
            models.append(Stats(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let stats = Stats(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: Stats Instance.
*/
	required public init?(dictionary: NSDictionary) {

		hp = dictionary["hp"] as? Int
		hpperlevel = dictionary["hpperlevel"] as? Int
		mp = dictionary["mp"] as? Int
		mpperlevel = dictionary["mpperlevel"] as? Int
		movespeed = dictionary["movespeed"] as? Int
		armor = dictionary["armor"] as? Int
		armorperlevel = dictionary["armorperlevel"] as? Int
		spellblock = dictionary["spellblock"] as? Int
		spellblockperlevel = dictionary["spellblockperlevel"] as? Double
		attackrange = dictionary["attackrange"] as? Int
		hpregen = dictionary["hpregen"] as? Double
		hpregenperlevel = dictionary["hpregenperlevel"] as? Double
		mpregen = dictionary["mpregen"] as? Int
		mpregenperlevel = dictionary["mpregenperlevel"] as? Double
		crit = dictionary["crit"] as? Int
		critperlevel = dictionary["critperlevel"] as? Int
		attackdamage = dictionary["attackdamage"] as? Int
		attackdamageperlevel = dictionary["attackdamageperlevel"] as? Double
		attackspeedperlevel = dictionary["attackspeedperlevel"] as? Double
		attackspeed = dictionary["attackspeed"] as? Double
	}

		
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.hp, forKey: "hp")
		dictionary.setValue(self.hpperlevel, forKey: "hpperlevel")
		dictionary.setValue(self.mp, forKey: "mp")
		dictionary.setValue(self.mpperlevel, forKey: "mpperlevel")
		dictionary.setValue(self.movespeed, forKey: "movespeed")
		dictionary.setValue(self.armor, forKey: "armor")
		dictionary.setValue(self.armorperlevel, forKey: "armorperlevel")
		dictionary.setValue(self.spellblock, forKey: "spellblock")
		dictionary.setValue(self.spellblockperlevel, forKey: "spellblockperlevel")
		dictionary.setValue(self.attackrange, forKey: "attackrange")
		dictionary.setValue(self.hpregen, forKey: "hpregen")
		dictionary.setValue(self.hpregenperlevel, forKey: "hpregenperlevel")
		dictionary.setValue(self.mpregen, forKey: "mpregen")
		dictionary.setValue(self.mpregenperlevel, forKey: "mpregenperlevel")
		dictionary.setValue(self.crit, forKey: "crit")
		dictionary.setValue(self.critperlevel, forKey: "critperlevel")
		dictionary.setValue(self.attackdamage, forKey: "attackdamage")
		dictionary.setValue(self.attackdamageperlevel, forKey: "attackdamageperlevel")
		dictionary.setValue(self.attackspeedperlevel, forKey: "attackspeedperlevel")
		dictionary.setValue(self.attackspeed, forKey: "attackspeed")

		return dictionary
	}

}
