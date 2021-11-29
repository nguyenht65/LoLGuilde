//
//  ItemsCell.swift
//  LoLGuilde
//
//  Created by Bang on 01/11/2021.
//

import UIKit
import SDWebImage

class ItemsCell: UICollectionViewCell {

    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    func setupData(item: Item) {
        print(item.urlImage)
        itemImageView.sd_setImage(with: URL(string: item.urlImage), placeholderImage: UIImage(named: item.placeholderImage))
        itemNameLabel.text = item.name
        if item.into?.isEmpty != nil && item.from?.isEmpty != nil {
            itemImageView.layer.borderColor = UIColor.systemYellow.cgColor
        } else if item.into?.isEmpty != nil {
            itemImageView.layer.borderColor = UIColor.systemGray.cgColor
        } else if item.from?.isEmpty != nil {
            itemImageView.layer.borderColor = UIColor.systemPink.cgColor
        } else {
            itemImageView.layer.borderColor = UIColor.systemMint.cgColor
        }
    }

    func setupUI() {
        itemImageView.layoutIfNeeded()
        itemImageView.layer.borderWidth = 1
        itemImageView.layer.masksToBounds = true
    }
}
