//
//  LoreView.swift
//  LoLGuilde
//
//  Created by Bang on 05/11/2021.
//

import UIKit

class LoreView: BaseView {

    @IBOutlet weak var loreLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setupData(item: Champion) {
        loreLabel.text = item.lore
    }
}
