//
//  EachStatusView.swift
//  LoLGuilde
//
//  Created by Bang on 08/11/2021.
//

import UIKit

@IBDesignable
class EachStatusView: BaseView {

    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var statusValueLabel: UILabel!

    private var _status: String = ""
    private var _textColor: UIColor = UIColor.white

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
        let cases = statusLabel.text
        switch cases {
        case "HEALTH":
            statusValueLabel.text?.append(contentsOf: "\(item.stats.hp)(\(item.stats.hpperlevel)")
        case "HEALTH REGEN":
            statusValueLabel.text?.append(contentsOf: "\(item.stats.hpregen)(\(item.stats.hpregenperlevel))")
        case "MANA":
            statusValueLabel.text?.append(contentsOf: "\(item.stats.mp)(\(item.stats.mpperlevel))")
        case "MANA REGEN":
            statusValueLabel.text?.append(contentsOf: "\(item.stats.mpregen)(\(item.stats.mpregenperlevel))")
        case "ATTACK DAMAGE":
            statusValueLabel.text?.append(contentsOf: "\(item.stats.attackdamage)(\(item.stats.attackdamageperlevel))")
        case "ATTACK SPEED":
            statusValueLabel.text?.append(contentsOf: "\(item.stats.attackspeed)(\(item.stats.attackspeedperlevel))")
        case "ARMOR":
            statusValueLabel.text?.append(contentsOf: "\(item.stats.armor)(\(item.stats.armorperlevel))")
        case "MAGIC RESIST":
            statusValueLabel.text?.append(contentsOf: "\(item.stats.spellblock)(\(item.stats.spellblockperlevel))")
        case "ATTACK RANGE":
            statusValueLabel.text?.append(contentsOf: "\(item.stats.attackrange)")
        case "MOVEMENT":
            statusValueLabel.text?.append(contentsOf: "\(item.stats.movespeed )")
        default:
            return
        }
    }
}
