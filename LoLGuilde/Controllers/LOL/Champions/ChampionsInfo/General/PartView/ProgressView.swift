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

    private var _label: String = ""
    private var _tintColor: UIColor = UIColor.white
    private var _championPropertyValue: Int = 0

    @IBInspectable
    var championPropertyValue: Int {
        set (newValue) {
            _championPropertyValue = newValue
        } get {
            return _championPropertyValue
        }
    }

    @IBInspectable
    var label: String {
        set (newValue) {
            _label = newValue
            infoLabel.text = _label
        } get {
            return _label
        }
    }

    @IBInspectable
    var progressTint: UIColor {
        set (newValue) {
            _tintColor = newValue
            infoProgessView.tintColor = _tintColor
        } get {
            return _tintColor
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
    }
    
    func setupData(item: Champion) {
        guard let championProperties = ChampionPropertyValues(rawValue: _championPropertyValue) else { return }
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
