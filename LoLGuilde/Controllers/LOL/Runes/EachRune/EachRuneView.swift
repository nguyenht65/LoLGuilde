//
//  EachRuneView.swift
//  LoLGuilde
//
//  Created by Bang on 10/11/2021.
//

import UIKit

class EachRuneView: BaseView {

    @IBOutlet weak var runeImage: UIImageView!

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func commonInit() {
        super.commonInit()
        runeImage.layer.borderColor = UIColor.systemYellow.cgColor
        runeImage.layer.borderWidth = 1
        runeImage.layer.cornerRadius = runeImage.bounds.height/2
        runeImage.layer.masksToBounds = true
    }
}
