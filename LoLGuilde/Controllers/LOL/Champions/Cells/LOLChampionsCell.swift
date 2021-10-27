//
//  LOLChampionsCell.swift
//  LoLGuilde
//
//  Created by Bang on 27/10/2021.
//

import UIKit

class LOLChampionsCell: UITableViewCell {

    @IBOutlet weak var championImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
