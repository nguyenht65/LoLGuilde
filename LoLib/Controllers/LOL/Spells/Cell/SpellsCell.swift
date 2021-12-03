//
//  SpellsCell.swift
//  LoLGuilde
//
//  Created by Bang on 04/11/2021.
//

import UIKit
import SDWebImage
import DeviceKit

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
        spellsImageView.setImageUrl(with: item.urlImage)
        spellImageView.layer.borderColor = UIColor.white.cgColor
    }

    func setupUI() {
        spellImageView.layoutIfNeeded()
        spellImageView.layer.borderWidth = 1
        spellImageView.layer.masksToBounds = true
        setDeviceConstraint()
    }

    private func setDeviceConstraint() {
        let device = Device.current
        switch device {
        case .simulator(.iPhoneSE):
            imageHeightConstraint.constant = 30
            break
        case .simulator(.iPhoneSE2), .simulator(.iPhone6s):
            imageHeightConstraint.constant = 40
            break
        default:
            break
        }
    }

}
