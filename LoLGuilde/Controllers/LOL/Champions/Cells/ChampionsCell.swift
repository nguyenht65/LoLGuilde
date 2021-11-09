//
//  ChampionsCell.swift
//  LoLGuilde
//
//  Created by Bang on 27/10/2021.
//

import UIKit
import SDWebImage

class ChampionsCell: UITableViewCell {

    @IBOutlet weak var championImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupData(item: Champion) {
        nameLabel.text = item.name
        titleLabel.text = item.title
        let urlImage = "https://nguyenht65.github.io/LOLResources/LoLResouces/lol/img/champion/\(item.image?.full ?? "")"
        championImageView.sd_setImage(with: URL(string: urlImage), placeholderImage: UIImage(named: "ic_tb1"))
    }
}
