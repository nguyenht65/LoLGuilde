//
//  EachStatusView.swift
//  LoLGuilde
//
//  Created by Bang on 08/11/2021.
//

import UIKit
import DeviceKit

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
        let device = Device.current
        switch device {
        case .simulator(.iPhoneSE):
            statusLabel.font = .systemFont(ofSize: 12)
            statusValueLabel.font = .systemFont(ofSize: 10)
            break // You're running on the iPad Air 2 simulator
        default:
            break
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
        switch championStatusValue {
        case .health:
            statusValueLabel.text?.append(contentsOf: "\(item.stats.hp)(\(item.stats.hpperlevel))")
        case .healthRegen:
            statusValueLabel.text?.append(contentsOf: "\(item.stats.hpregen)(\(item.stats.hpregenperlevel))")
        case .mana:
            statusValueLabel.text?.append(contentsOf: "\(item.stats.mp)(\(item.stats.mpperlevel))")
        case .manaRegen:
            statusValueLabel.text?.append(contentsOf: "\(item.stats.mpregen)(\(item.stats.mpregenperlevel))")
        case .attackDamage:
            statusValueLabel.text?.append(contentsOf: "\(item.stats.attackdamage)(\(item.stats.attackdamageperlevel))")
        case .attackSpeed:
            statusValueLabel.text?.append(contentsOf: "\(item.stats.attackspeed)(\(item.stats.attackspeedperlevel))")
        case .armor:
            statusValueLabel.text?.append(contentsOf: "\(item.stats.armor)(\(item.stats.armorperlevel))")
        case .spellBlock:
            statusValueLabel.text?.append(contentsOf: "\(item.stats.spellblock)(\(item.stats.spellblockperlevel))")
        case .attackRange:
            statusValueLabel.text?.append(contentsOf: "\(item.stats.attackrange)")
        case .moveSpeed:
            statusValueLabel.text?.append(contentsOf: "\(item.stats.movespeed )")
        }
    }
}
