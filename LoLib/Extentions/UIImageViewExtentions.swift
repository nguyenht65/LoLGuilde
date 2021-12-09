//
//  UIImageViewExtentions.swift
//  LoLib
//
//  Created by Bang on 03/12/2021.
//

import UIKit
import SDWebImage

extension UIImageView {
    
    func setImageUrl(with path: String, placeHolder: String = Image.LoadingImage.square.rawValue) {
        self.sd_setImage(with: URL(string:path), placeholderImage: UIImage(named: placeHolder))
    }
}
