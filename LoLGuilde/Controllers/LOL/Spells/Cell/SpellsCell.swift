//
//  SpellsCell.swift
//  LoLGuilde
//
//  Created by Bang on 04/11/2021.
//

import UIKit
import SDWebImage

class SpellsCell: UICollectionViewCell {

    @IBOutlet weak var spellImageView: UIImageView!
    @IBOutlet weak var spellNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    func setupData(item: Spell) {
        spellNameLabel.text = item.name
        spellImageView.sd_setImage(with: URL(string: item.urlImage), placeholderImage: UIImage(named: item.placeholderImage))
        spellImageView.layer.borderColor = UIColor.white.cgColor
    }

    func setupUI() {
        spellImageView.layoutIfNeeded()
        spellImageView.layer.borderWidth = 1
        spellImageView.layer.masksToBounds = true
    }
}
