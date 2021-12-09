//
//  StatusView.swift
//  LoLGuilde
//
//  Created by Bang on 08/11/2021.
//

import UIKit

class StatusView: BaseView {

    @IBOutlet weak var healthView: EachStatusView!
    @IBOutlet weak var healthRegenView: EachStatusView!
    @IBOutlet weak var manaView: EachStatusView!
    @IBOutlet weak var manaRegenView: EachStatusView!
    @IBOutlet weak var attackDamageView: EachStatusView!
    @IBOutlet weak var attackSpeedView: EachStatusView!
    @IBOutlet weak var armorView: EachStatusView!
    @IBOutlet weak var magicResistView: EachStatusView!
    @IBOutlet weak var attackRangeView: EachStatusView!
    @IBOutlet weak var movementView: EachStatusView!
    @IBOutlet weak var statusViewHeightConstraint: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func commonInit() {
        super.commonInit()
        setDeviceConstraint()
    }

    private func setDeviceConstraint() {
        if DeviceHelper().isSmallDevice() {
            statusViewHeightConstraint.constant = 30
        }
    }

    func setupData(item: Champion) {
        healthView.setupData(item: item)
        healthRegenView.setupData(item: item)
        manaView.setupData(item: item)
        manaRegenView.setupData(item: item)
        attackDamageView.setupData(item: item)
        attackSpeedView.setupData(item: item)
        armorView.setupData(item: item)
        magicResistView.setupData(item: item)
        attackRangeView.setupData(item: item)
        movementView.setupData(item: item)
    }
}
