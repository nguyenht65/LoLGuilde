//
//  EachStatusView.swift
//  LoLGuilde
//
//  Created by Bang on 08/11/2021.
//

import UIKit

enum ChampionStatusValue: Int {
    case health = 0
    case healthRegen = 1
    case mana = 2
    case manaRegen = 3
    case attackDamage = 4
    case attackSpeed = 5
    case armor = 6
    case spellBlock = 7
    case attackRange = 8
    case moveSpeed = 9
}

@IBDesignable
class EachStatusView: BaseView {

    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var statusValueLabel: UILabel!

    private var tempStatus: String = ""
    private var tempTextColor: UIColor = UIColor.white
    private var tempStatusValue: Int = 0

    @IBInspectable
    var championStatusValue: Int {
        set (newValue) {
            tempStatusValue = newValue
        } get {
            return tempStatusValue
        }
    }
    
    @IBInspectable
    var status: String {
        set (newValue) {
            tempStatus = newValue
            statusLabel.text = tempStatus
        } get {
            return tempStatus
        }
    }

    @IBInspectable
    var textColor: UIColor {
        set (newValue) {
            tempTextColor = newValue
            statusValueLabel.textColor = tempTextColor
        } get {
            return tempTextColor
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setDeviceConstraint() {
        if DeviceHelper().isSmallDevice() {
            statusLabel.font = .systemFont(ofSize: 12)
            statusValueLabel.font = .systemFont(ofSize: 10)
        }
    }

    override func commonInit() {
        let bundle = Bundle.init(for: EachStatusView.self)
        guard let viewToAdd = bundle.loadNibNamed(EachStatusView.className, owner: self, options: nil), let contentView = viewToAdd.first as? UIView else {
            return
        }
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        setDeviceConstraint()
    }

    func setupData(item: Champion) {
        guard let championStatusValue = ChampionStatusValue(rawValue: tempStatusValue) else { return }
        statusValueLabel.text?.append(contentsOf: item.getStatus(championStatusValue: championStatusValue))
    }
}
