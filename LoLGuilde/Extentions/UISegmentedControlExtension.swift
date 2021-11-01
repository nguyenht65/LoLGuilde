//
//  UISegmentedControlExtension.swift
//  GMap
//
//  Created by Chu Văn Hưng on 28/07/2021.
//

import Foundation
import UIKit

extension UISegmentedControl {

    func removeBorders() {
        setBackgroundImage(imageWithColor(color: backgroundColor ?? .clear), for: .normal, barMetrics: .default)
        setBackgroundImage(imageWithColor(color: tintColor!), for: .selected, barMetrics: .default)
        setDividerImage(imageWithColor(color: UIColor.clear), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
    }

    // create a 1x1 image with this color
    private func imageWithColor(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0.0, y: 0.0, width:  1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor);
        context!.fill(rect);
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image!
    }

    func ensureiOS12Style() {
        if #available(iOS 13, *) {
            // Must set the background image for normal to something (even clear) else the rest won't work
            setBackgroundImage(imageWithColor(color: backgroundColor ?? .clear), for: .normal, barMetrics: .default)
            setBackgroundImage(imageWithColor(color: selectedSegmentTintColor ?? tintColor), for: .selected, barMetrics: .default)
            setBackgroundImage(imageWithColor(color: selectedSegmentTintColor?.withAlphaComponent(0.2) ?? tintColor.withAlphaComponent(0.2)), for: .highlighted, barMetrics: .default)
            setBackgroundImage(imageWithColor(color: selectedSegmentTintColor ?? tintColor), for: [.highlighted, .selected], barMetrics: .default)
            setTitleTextAttributes([.foregroundColor: tintColor as Any, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13, weight: .regular)], for: .normal)
            setDividerImage(imageWithColor(color: tintColor), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
            layer.borderWidth = 1
            layer.borderColor = tintColor.cgColor
        }
    }
}
