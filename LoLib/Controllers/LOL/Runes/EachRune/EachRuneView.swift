//
//  EachRuneView.swift
//  LoLGuilde
//
//  Created by Bang on 10/11/2021.
//

import UIKit

@IBDesignable
class EachRuneView: BaseView {

    @IBOutlet weak var runeImage: UIImageView!
    @IBOutlet weak var imageButton: UIButton!

    private var tagValue: Int = 0

    @IBInspectable
    var buttonTag: Int {
        get {
            return tagValue
        } set(newValue) {
            tagValue = newValue
            imageButton.tag = tagValue
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func commonInit() {
        super.commonInit()
        layer.borderColor = UIColor.systemYellow.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = self.bounds.height/2
        layer.masksToBounds = true
    }

    func setupUI(item: Rune, slotsIndex: Int, runeIndex: Int) {
        let urlImage = item.urlImage + item.slots[slotsIndex].runes[runeIndex].icon
        runeImage.sd_setImage(with: URL(string: urlImage), placeholderImage: UIImage(named: item.placeholderImage))
    }

}
