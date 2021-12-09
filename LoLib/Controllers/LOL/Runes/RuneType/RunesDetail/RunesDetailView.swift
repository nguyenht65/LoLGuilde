//
//  RunesDetailView.swift
//  LoLGuilde
//
//  Created by Bang on 15/11/2021.
//

import UIKit

class RunesDetailView: BaseView {

    @IBOutlet weak var runesImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func commonInit() {
        super.commonInit()
        setupUI()
    }

    func setupUI() {
        runesImageView.layer.borderWidth = 1
        runesImageView.layer.cornerRadius = runesImageView.layer.bounds.height / 2
        runesImageView.layer.borderColor = UIColor.systemYellow.cgColor
        runesImageView.layer.masksToBounds = true
    }

    @IBAction func closeButtonAction(_ sender: UIButton) {
        self.removeFromSuperview()
    }

    func setupData(item: Rune, slotsIndex: Int, runeIndex: Int) {
        nameLabel.text = item.slots[slotsIndex].runes[runeIndex].name
        let urlImage = item.urlImage + item.slots[slotsIndex].runes[runeIndex].icon
        runesImageView.setImageUrl(with: urlImage)
        descriptionTextView.text = item.slots[slotsIndex].runes[runeIndex].longDesc.htmlToString
    }

}
