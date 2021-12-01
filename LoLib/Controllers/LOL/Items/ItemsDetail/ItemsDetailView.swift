//
//  ItemsDetailView.swift
//  LoLGuilde
//
//  Created by Bang on 15/11/2021.
//

import UIKit

class ItemsDetailView: BaseView {

    @IBOutlet weak var itemsImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var goldLabel: UILabel!
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
    
    func setupData(item: Item) {
        nameLabel.text = item.name
        goldLabel.text = "$\(item.gold.total) - $\(item.gold.sell)"
        descriptionTextView.text = item.description.htmlToString
        itemsImageView.sd_setImage(with: URL(string: item.urlImage), placeholderImage: UIImage(named: item.placeholderImage))
    }
}