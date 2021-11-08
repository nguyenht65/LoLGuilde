//
//  ProgressView.swift
//  LoLGuilde
//
//  Created by Bang on 08/11/2021.
//

import UIKit

@IBDesignable
class ProgressView: BaseView {

    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var infoProgessView: UIProgressView!
    
    private var _label: String = ""
    private var _tintColor: UIColor = UIColor.white

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
        if infoLabel.text == "Attack" {
            infoProgessView.setProgress(Float((item.info?.attack) ?? 0)/10, animated: true)
        } else if infoLabel.text == "Defense" {
            infoProgessView.setProgress(Float((item.info?.defense) ?? 0)/10, animated: true)
        } else if infoLabel.text == "Magic" {
            infoProgessView.setProgress(Float((item.info?.magic) ?? 0)/10, animated: true)
        } else {
            infoProgessView.setProgress(Float((item.info?.difficulty) ?? 0)/10, animated: true)
        }
    }
}
