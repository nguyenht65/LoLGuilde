//
//  UIViewController.swift
//  GMap
//
//  Created by Chu Văn Hưng on 26/07/2021.
//

import Foundation
import UIKit

extension UIViewController {

    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: T.className, bundle: Bundle.main)
        }
        return instantiateFromNib()
    }

    static func newController(fromStoryboard name: String) -> UIViewController {
        let storyboard = UIStoryboard(name: name, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: self.className)
    }
}

extension NSObject {
    var className: String {
        return String(describing: type(of: self)).components(separatedBy: ".").last!
    }
    
    class var className: String {
        return String(describing: self).components(separatedBy: ".").last!
    }
}

