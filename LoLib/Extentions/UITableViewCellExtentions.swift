//
//  UITableViewCellExtentions.swift
//  LoLib
//
//  Created by Bang on 02/12/2021.
//

import Foundation
import UIKit

extension UITableView {

    func dequeueCell<T: UITableViewCell>(_ aClass: T.Type) -> T {
            let className = String(describing: aClass)
            guard let cell = dequeueReusableCell(withIdentifier: className) as? T else {
                fatalError("`\(className)` is not registed")
            }
            return cell
        }
}
