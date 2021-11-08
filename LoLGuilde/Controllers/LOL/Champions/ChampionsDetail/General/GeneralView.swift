//
//  GeneralView.swift
//  LoLGuilde
//
//  Created by Bang on 04/11/2021.
//

import UIKit

class GeneralView: BaseView {

    @IBOutlet weak var attackView: ProgressView!
    @IBOutlet weak var defenseView: ProgressView!
    @IBOutlet weak var magicView: ProgressView!
    @IBOutlet weak var difficultyView: ProgressView!

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func commonInit() {
        super.commonInit()
    }

    func setupData(item: Champion) {
        attackView.setupData(item: item)
        defenseView.setupData(item: item)
        magicView.setupData(item: item)
        difficultyView.setupData(item: item)
    }
}
