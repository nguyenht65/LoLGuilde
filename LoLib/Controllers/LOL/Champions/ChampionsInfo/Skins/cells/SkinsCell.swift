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
        let skinImage = item.skins[index].urlImage
        let skinId = item.id + "_"
        let skinNumber = item.skins[index].num
        let imageFormat = item.skins[index].imageFormat
        let urlImage = skinImage + skinId + String(skinNumber) + imageFormat
        skinsImageView.setImageUrl(with: urlImage, placeHolder: UIImage(named: Image.LoadingImage.rectangle.rawValue))
    }
}
