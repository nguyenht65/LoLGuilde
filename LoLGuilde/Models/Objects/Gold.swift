/* 
Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

import Foundation
 
/* For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar */

public class Gold: Codable {
	public var base : Int?
	public var purchasable : Bool?
	public var total : Int?
	public var sell : Int?

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let gold = Gold(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: Gold Instance.
*/
	required public init?(dictionary: NSDictionary) {

		base = dictionary["base"] as? Int
		purchasable = dictionary["purchasable"] as? Bool
		total = dictionary["total"] as? Int
		sell = dictionary["sell"] as? Int
	}

		
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.base, forKey: "base")
		dictionary.setValue(self.purchasable, forKey: "purchasable")
		dictionary.setValue(self.total, forKey: "total")
		dictionary.setValue(self.sell, forKey: "sell")

		return dictionary
	}

}
