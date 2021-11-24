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

    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
        if let navigationController = self.navigationController {
            navigationController.view.endEditing(true)
        }
    }
}
