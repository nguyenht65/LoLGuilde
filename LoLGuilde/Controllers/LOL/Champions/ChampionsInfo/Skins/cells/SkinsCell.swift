//
//  SkinsCell.swift
//  LoLGuilde
//
//  Created by Bang on 10/11/2021.
//

import UIKit

class SkinsCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var skinsImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setupData(item: Champion, index: Int) {
        nameLabel.text = item.skins[index].name
        let urlImage = "\(Image.EndPoint.skin.urlString)\(item.id )_\(item.skins[index].num ).jpg"
        skinsImageView.sd_setImage(with: URL(string: urlImage), placeholderImage: UIImage(named: "loading"))
    }
}
