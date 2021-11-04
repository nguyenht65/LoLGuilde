//
//  GeneralView.swift
//  LoLGuilde
//
//  Created by Bang on 04/11/2021.
//

import UIKit

class GeneralView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        self.initViewWithNib()
    }
}
