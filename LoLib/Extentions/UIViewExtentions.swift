//
//  UIViewExtentions.swift
//  LoLGuilde
//
//  Created by Bang on 04/11/2021.
//

import UIKit

extension UIView {

    class func fromNib<T: UIView>() -> T? {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as? T
    }

    func loadViewFromNib() -> UIView? {
        let bundle = Bundle.main
        let nib = UINib(nibName: "\(type(of: self))", bundle: bundle)
        return nib.instantiate(
            withOwner: self,
            options: nil).first as? UIView
    }

    func initViewWithNib() {
        guard let view = loadViewFromNib() else { return }
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }
}
