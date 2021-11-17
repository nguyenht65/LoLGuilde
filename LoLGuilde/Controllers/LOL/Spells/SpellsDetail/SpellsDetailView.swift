//
//  SpellsDetailView.swift
//  LoLGuilde
//
//  Created by Bang on 15/11/2021.
//

import UIKit

class SpellsDetailView: BaseView {

    @IBOutlet weak var spellsImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cooldownLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    @IBAction func closeButtonAction(_ sender: UIButton) {
        self.removeFromSuperview()
    }

    func setupData(item: Spells) {
//        nameLabel.text = item.name
//        cooldownLabel.text = "Cooldown: \(item.cooldownBurn ?? "")s"
//        descriptionTextView.text = item.description?.htmlToString
//        let urlImage = "https://nguyenht65.github.io/LOLResources/LoLResouces/lol/img/spell/\(item.image?.full ?? "")"
//        spellsImageView.sd_setImage(with: URL(string: urlImage), placeholderImage: UIImage(named: "loading_2"))
    }
}
