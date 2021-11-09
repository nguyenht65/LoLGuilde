//
//  SkillsView.swift
//  LoLGuilde
//
//  Created by Bang on 05/11/2021.
//

import UIKit

class SkillsView: BaseView {

    @IBOutlet weak var passiveView: PassiveView!
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setupData(item: Champion) {
        passiveView.setupData(item: item)
    }
}
