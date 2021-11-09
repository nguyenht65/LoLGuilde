//
//  PassiveView.swift
//  LoLGuilde
//
//  Created by Bang on 09/11/2021.
//

import UIKit
import SDWebImage

class PassiveView: BaseView {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupData(item: Champion) {
        nameLabel.text = item.passive?.name
        descriptionTextView.text = item.passive?.description
        let urlStringImage = "https://nguyenht65.github.io/LOLResources/LoLResouces/lol/img/passive/\(item.passive?.image?.full ?? "")"
        imageView.sd_setImage(with: URL(string: urlStringImage), placeholderImage: UIImage(named: "ic_tb1"))
    }
}
