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

    private var _status: String = ""
    private var _textColor: UIColor = UIColor.white
    private var _championStatusValue: Int = 0

    @IBInspectable
    var championStatusValue: Int {
        set (newValue) {
            _championStatusValue = newValue
        } get {
            return _championStatusValue
        }
    }
    
    @IBInspectable
    var status: String {
        set (newValue) {
            _status = newValue
            statusLabel.text = _status
        } get {
            return _status
        }
    }

    @IBInspectable
    var textColor: UIColor {
        set (newValue) {
            _textColor = newValue
            statusValueLabel.textColor = _textColor
        } get {
            return _textColor
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func commonInit() {
        let bundle = Bundle.init(for: EachStatusView.self)
        guard let viewToAdd = bundle.loadNibNamed(EachStatusView.className, owner: self, options: nil), let contentView = viewToAdd.first as? UIView else {
            return
        }
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }

    func setupData(item: Champion) {
        guard let championStatusValue = ChampionStatusValue(rawValue: _championStatusValue) else { return }
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
