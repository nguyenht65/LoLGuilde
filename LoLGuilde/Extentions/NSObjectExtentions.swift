//
//  NSObjectExtentions.swift
//  LoLGuilde
//
//  Created by Bang on 06/11/2021.
//

import Foundation

extension NSObject {

    var className: String {
        return String(describing: type(of: self)).components(separatedBy: ".").last!
    }

    class var className: String {
        return String(describing: self).components(separatedBy: ".").last!
    }
}
