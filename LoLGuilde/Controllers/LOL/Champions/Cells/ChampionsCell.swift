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
    }

    func setupData(item: Champion) {
        nameLabel.text = item.name
        titleLabel.text = item.title
        championImageView.sd_setImage(with: URL(string: item.urlImage), placeholderImage: UIImage(named: item.placeholderImage))
    }
}
