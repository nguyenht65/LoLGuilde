//
//  SpellsDetailView.swift
//  LoLGuilde
//
//  Created by Bang on 15/11/2021.
//

import UIKit
import DeviceKit

class SpellsDetailView: BaseView {

    @IBOutlet weak var spellsImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cooldownLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    
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
        let device = Device.current
        switch device {
        case .simulator(.iPhoneSE):
            imageHeightConstraint.constant = 30
            break
        case .simulator(.iPhoneSE2), .simulator(.iPhone6s):
            imageHeightConstraint.constant = 40
            break
        default:
            break
        }
    }

    @IBAction func closeButtonAction(_ sender: UIButton) {
        self.removeFromSuperview()
    }

    func setupData(item: Spell) {
        nameLabel.text = item.name
        cooldownLabel.text = "\(StringConstant.cooldown)\(item.cooldownBurn)\(StringConstant.second)"
        descriptionTextView.text = item.description.htmlToString
        spellsImageView.setImageUrl(with: item.urlImage)
    }
}
