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

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    func setupData(item: Spell){
        spellNameLabel.text = item.name
        let urlStringImage = "https://nguyenht65.github.io/LOLResources/LoLResouces/lol/img/spell/\(item.image?.full ?? "")"
        spellImageView.sd_setImage(with: URL(string: urlStringImage), placeholderImage: UIImage(named: "tc_tb1"))
        spellImageView.layer.borderColor = UIColor.white.cgColor
    }

    func setupUI(){
        spellImageView.layoutIfNeeded()
        spellImageView.layer.borderWidth = 1
        spellImageView.layer.masksToBounds = true
    }
}
