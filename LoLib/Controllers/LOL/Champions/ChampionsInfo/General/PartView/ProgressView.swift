//
//  ProgressView.swift
//  LoLGuilde
//
//  Created by Bang on 08/11/2021.
//

import UIKit

enum ChampionPropertyValues: Int {
    case attack = 0
    case defense = 1
    case magic = 2
    case difficulty = 3
}

@IBDesignable
class ProgressView: BaseView {

    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var infoProgessView: UIProgressView!

    private var tempLabel: String = ""
    private var tempTintColor: UIColor = UIColor.white
    private var tempPropertyValue: Int = 0

    @IBInspectable
    var championPropertyValue: Int {
        set (newValue) {
            tempPropertyValue = newValue
        } get {
            return tempPropertyValue
        }
    }

    @IBInspectable
    var label: String {
        set (newValue) {
            tempLabel = newValue
            infoLabel.text = tempLabel
        } get {
            return tempLabel
        }
    }

    @IBInspectable
    var progressTint: UIColor {
        set (newValue) {
            tempTintColor = newValue
            infoProgessView.tintColor = tempTintColor
        } get {
            return tempTintColor
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func commonInit() {
        let bundle = Bundle.init(for: ProgressView.self)
        guard let viewToAdd = bundle.loadNibNamed(ProgressView.className, owner: self, options: nil), let contentView = viewToAdd.first as? UIView else {
            return
        }
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        setDeviceConstraint()
    }

    private func setDeviceConstraint() {
        if DeviceHelper().isSmallDevice() {
            infoLabel.font = .systemFont(ofSize: 13)
        }
    }

    func setupData(item: Champion) {
        guard let championProperties = ChampionPropertyValues(rawValue: tempPropertyValue) else { return }
        switch championProperties {
        case .attack:
            infoProgessView.setProgress(Float(item.info.attack)/10, animated: true)
        case .defense:
            infoProgessView.setProgress(Float(item.info.defense)/10, animated: true)
        case .magic:
            infoProgessView.setProgress(Float(item.info.magic)/10, animated: true)
        case .difficulty:
            infoProgessView.setProgress(Float(item.info.difficulty)/10, animated: true)
        }
    }
}
