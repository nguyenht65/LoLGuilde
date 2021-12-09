//
//  SpellsCell.swift
//  LoLGuilde
//
//  Created by Bang on 04/11/2021.
//

import UIKit

class SpellsCell: UICollectionViewCell {

    @IBOutlet weak var spellImageView: UIImageView!
    @IBOutlet weak var spellNameLabel: UILabel!
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    func setupData(item: Spell) {
        spellNameLabel.text = item.name
        spellImageView.setImageUrl(with: item.urlImage)
        spellImageView.layer.borderColor = UIColor.white.cgColor
    }

    func setupUI() {
        spellImageView.layoutIfNeeded()
        spellImageView.layer.borderWidth = 1
        spellImageView.layer.masksToBounds = true
        setDeviceConstraint()
    }

    private func setDeviceConstraint() {
        if DeviceHelper().isSmallDevice() {
            imageHeightConstraint.constant = 30
        }
    }

}
