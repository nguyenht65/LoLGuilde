//
//  SkillsCell.swift
//  LoLGuilde
//
//  Created by Bang on 09/11/2021.
//

import UIKit
import SDWebImage

class SkillsCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var skillImageView: UIImageView!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var cooldownLabel: UILabel!
    @IBOutlet weak var rangeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UITextView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupData(item: Champion, index: Int) {
        nameLabel.text = item.spells?[index].name
        costLabel.text?.append(contentsOf: "\(item.spells?[index].costBurn ?? "") mana")
        cooldownLabel.text?.append(contentsOf: "\(item.spells?[index].cooldownBurn ?? "")s")
        rangeLabel.text?.append(contentsOf: "\(item.spells?[index].rangeBurn ?? "")")
        descriptionLabel.text = item.spells?[index].description?.htmlToString
        let urlStringImage = "https://nguyenht65.github.io/LOLResources/LoLResouces/lol/img/spell/\(item.spells?[index].image?.full ?? "")"
        skillImageView.sd_setImage(with: URL(string: urlStringImage), placeholderImage: UIImage(named: "ic_tb1"))
    }
}
