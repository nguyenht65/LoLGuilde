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
<<<<<<< HEAD
    private var _textColor: UIColor = UIColor.white

    @IBInspectable
    var label: String {
=======
    private var _textColor: UIColor = UIColor(named: "textColor")!

    @IBInspectable
    var status: String {
>>>>>>> 598ccc9d5f3b822b097d6d06a417fbdeb29b405e
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
<<<<<<< HEAD
            statusValueLabel.textColor = _textColor
=======
            statusLabel.textColor = _textColor
>>>>>>> 598ccc9d5f3b822b097d6d06a417fbdeb29b405e
        } get {
            return _textColor
        }
    }
<<<<<<< HEAD

=======
    
>>>>>>> 598ccc9d5f3b822b097d6d06a417fbdeb29b405e
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
<<<<<<< HEAD

    func setupData(item: Champion) {
        let cases = statusLabel.text
        switch cases {
        case "HEALTH":
            statusValueLabel.text?.append(contentsOf: "\(item.stats?.hp ?? 0)(\(item.stats?.hpperlevel ?? 0))")
        case "HEALTH REGEN":
            statusValueLabel.text?.append(contentsOf: "\(item.stats?.hpregen ?? 0)(\(item.stats?.hpregenperlevel ?? 0))")
        case "MANA":
            statusValueLabel.text?.append(contentsOf: "\(item.stats?.mp ?? 0)(\(item.stats?.mpperlevel ?? 0))")
        case "MANA REGEN":
            statusValueLabel.text?.append(contentsOf: "\(item.stats?.mpregen ?? 0)(\(item.stats?.mpregenperlevel ?? 0))")
        case "ATTACK DAMAGE":
            statusValueLabel.text?.append(contentsOf: "\(item.stats?.attackdamage ?? 0)(\(item.stats?.attackdamageperlevel ?? 0))")
        case "ATTACK SPEED":
            statusValueLabel.text?.append(contentsOf: "\(item.stats?.attackspeed ?? 0)(\(item.stats?.attackspeedperlevel ?? 0))")
        case "ARMOR":
            statusValueLabel.text?.append(contentsOf: "\(item.stats?.armor ?? 0)(\(item.stats?.armorperlevel ?? 0))")
        case "MAGIC RESIST":
            statusValueLabel.text?.append(contentsOf: "\(item.stats?.spellblock ?? 0)(\(item.stats?.spellblockperlevel ?? 0))")
        case "ATTACK RANGE":
            statusValueLabel.text?.append(contentsOf: "\(item.stats?.attackrange ?? 0)")
        case "MOVEMENT":
            statusValueLabel.text?.append(contentsOf: "\(item.stats?.movespeed ?? 0)")
        default:
            return
        }
    }
=======
>>>>>>> 598ccc9d5f3b822b097d6d06a417fbdeb29b405e
}
