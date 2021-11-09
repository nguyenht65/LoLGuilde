//
//  PassiveCell.swift
//  LoLGuilde
//
//  Created by Bang on 09/11/2021.
//

import UIKit

class PassiveCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var passiveImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupData(item: Champion) {
        nameLabel.text = item.passive?.name
        descriptionTextView.text = item.passive?.description
        let urlStringImage = "https://nguyenht65.github.io/LOLResources/LoLResouces/lol/img/passive/\(item.passive?.image?.full ?? "")"
        passiveImageView.sd_setImage(with: URL(string: urlStringImage), placeholderImage: UIImage(named: "ic_tb1"))
    }
}
